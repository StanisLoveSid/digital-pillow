class AddCheckoutAddresses < Rectify::Command
  def initialize(order, params)
    @order = order
    @params = params
  end

  def call
    transaction do
      set_billing
      @billing.valid? ? save_billing : write_errors(:billing, @billing)
    end
    return broadcast(:invalid) if @order.errors.any?
    broadcast(:ok)
  end

  private

  def set_billing
    @billing = AddressForm.from_params(@params[:billing])
  end

  def save_billing
    @order.order_billing.delete if @order.order_billing
    Address.create @billing.address
  end

  def write_errors(type, address)
    @order.errors[type].concat address.errors.full_messages
  end
end
