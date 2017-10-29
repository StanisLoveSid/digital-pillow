class UpdateOrder < Rectify::Command
  def initialize(params)
    @params = params[:order][:order_items_attributes]
    @order_params = params
  end

  def call
    find_order
    find_order_item
    find_book
    check_avaliable_quantity
    return broadcast(:invalid) if !write_errors.empty?
    update_order
    broadcast(:ok)
  end

  private

  def update_order
    @order.update(order_params)
  end

  def find_order
    @order = Order.find(@order_params[:id])
  end

  def find_book
    @book = Book.find_by(order_params[:book_id])
  end

  def find_order_item
    @order_item = OrderItem.find_by(@order_params[:order_items_attributes][:id])
  end

  def check_avaliable_quantity
    write_errors if @book.quantity < @order_item.quantity
  end

  def write_errors
    @order.errors.add(:base, "invalid quantity")
  end

  def order_params
    @order_params.require(:order).permit(:subtotal, :coupon, 
      order_items_attributes: [:id, :quantity, :book_id])
  end
end