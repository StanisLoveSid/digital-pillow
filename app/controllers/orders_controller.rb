class OrdersController < ApplicationController

  def update
    @order = Order.find(params[:id])
    @order.update(order_params) 
    redirect_to "/cart"
  end

  def create
    CreateOrder.call(params) do
      on(:ok)       { redirect_to cart_path }
      on(:invalid)  {  }
    end
  end

  def edit
    @items = current_order.order_items
    @order_items = @items.sort_by(&:quantity).reverse
    @order = current_order
  end

  def resume_not_comleted_order
    session[:order_id] = params[:id]
    redirect_to "/cart"
  end

  def show
    @user = current_user
    @order = Order.find(params[:id])
  end

  def index
    @user_orders = current_user.orders
    if params[:filter] == 'All'
      @orders = @user_orders
      @status = 'Усі'
    elsif params[:filter] == 'Waiting for processing'
      @orders = @user_orders.in_queue
      @status = "Замовлення у черзі"
    elsif params[:filter] == 'Payed'
      @orders = @user_orders.payed
      @status = "Буде оплачено готівкою"      
    elsif params[:filter] == 'In delivery'
      @orders = @user_orders.in_delivery
      @status = "У стані доставки"
    elsif params[:filter] == 'Delivered'
      @orders = @user_orders.delivered
      @status = "Доставлено"
    elsif params[:filter] == "In progress"
      @orders = @user_orders.in_progress + @user_orders.filled
      @status = "Не заповнене до кінця"
    elsif params[:filter] == "Canceled"
      @orders = @user_orders.canceled
      @status = "Замовлення відхилено"      
    else 
      @orders = @user_orders
    end
  end

  private

  def order_params
    params.require(:order).permit(:subtotal, :coupon, 
      order_items_attributes: [:id, :quantity, :book_id])
  end
end
