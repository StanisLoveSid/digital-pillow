class CheckoutsController < ApplicationController
  require 'privatbank/p24'
  include Rectify::ControllerHelpers
  include Wicked::Wizard
  steps :address, :delivery, :payment, :confirm, :complete
  before_action :authenticate_user!
  before_action :set_step


  def show
    @user = current_user
    @order = current_order
    render_wizard
  end

  def update
    @order = current_order
    case step
    when :address
      AddCheckoutAddresses.call(@order, params) do
        on(:ok) do
          if @order.filled?
            redirect_to(checkout_path(:confirm))
          else
            render_wizard @order
          end
        end
        on(:invalid) do
          render_wizard
        end
      end
    when :delivery
      @order.update(order_params)
      if @order.delivery.name == 'none'
        render_wizard
      else
        if @order.filled?
          redirect_to(checkout_path(:confirm))
        else
          render_wizard @order
        end
      end
    when :payment
      AddCheckoutPayment.call(@order, params) do
        on(:ok)  do
          @order.aasm.current_state = :filled
          Privatbank::P24.send_money_pb('5168742604978688', '22', '2020', 'details')   
          render_wizard @order
        end
        on(:empty_address) {redirect_to(checkout_path(:address))}
        on(:empty_delivery) {redirect_to(checkout_path(:delivery))}
        on(:invalid)    { render_wizard }
        on(:pay_later) do
          @order.aasm.current_state = :filled
          @order.update(order_params)
          render_wizard @order
        end
      end
    when :confirm
      @redirection_counter = []
      @redirection_counter << "redirected" if performed?
      @order.order_items.each do |oi| 
        if oi.book.available
          oi.book.save!
        end 
      end
      OrderMailer.send_order(@order, current_user).deliver
      @order.complete
      @order.payed_with_cash!
      render_wizard @order
    end
  end

  private

  def set_step
    if step != :complete
    redirect_to root_path unless current_order.order_items.any?
    end
    case step
    when :confirm
      redirect_to root_path if !current_order.filled?
    end
  end

  def order_params
    params.require(:order).permit(:delivery_id, :subtotal, :user_id, :allow, :nova_poshta_delivery)
  end

end
