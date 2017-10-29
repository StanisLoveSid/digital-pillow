class AddCheckoutPayment < Rectify::Command
  
  def initialize(order, params)
    @order = order
    @params = params[:order][:credit_card_attributes]
    @order_params = params[:order]
  end

  def call
    return broadcast(:pay_later) if pay_later?
    return broadcast(:empty_address) if @order.order_billing.nil?
    return broadcast(:empty_delivery) if @order.delivery.name == 'none'
    @order.allow = @order_params[:allow]
    broadcast(:ok)
  end

  private

  def pay_later?
    @order_params[:allow] == '1'
  end

  def build_credit_card
    @credit_card = CreditCardForm.from_params @params
  end

  def save_card
    new_card = CreditCard.create @credit_card.to_h
    new_card.orders << @order
  end


end
