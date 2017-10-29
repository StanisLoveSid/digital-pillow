class PricesController < ApplicationController
  def create
  	@book = Book.find(params[:price][:book_id])
  	@book.prices.new prices_params
    if @book.save 
  	  @book.publish! if @book.aasm_state == "unpublished"
  	  redirect_to @book
    else
      redirect_to @book
      flash[:alert] = "Цена и размер должны быть заполнены"
    end
  end

  private

  def prices_params
  	params.require(:price).permit(:price, :size, :book_id)
  end
end
