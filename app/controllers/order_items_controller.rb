class OrderItemsController < ApplicationController

  before_action :set_book, only: [:create]

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @book.bestseller = true if @book.pick_times >= 4
    if @order_item.quantity <= @book.quantity
    @book.pick_times += 1 * @order_item.quantity
    @book.save
    @order.save 
    end
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params) 
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
  end

  def discount
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.unit_price -= 1 
    @order_item.save
    redirect_to root_path
  end


  private

  def set_book
    @book = Book.find(order_item_params[:book_id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :price_id, :unit_price, :unit_weight)
  end
end
