class AuthorsController < ApplicationController
  def create
  	@book = Book.find(params[:author][:book_id])
        @author = Author.find_by(name: params[:author][:name])
        @author == nil ? @book.authors.new(authors_params) : (@author.books << @book)  
    if @book.save 
      flash[:success] = "Назву виробника добавлено"
  	  redirect_to @book
    else
      redirect_to @book
      flash[:alert] = "Имя должно быть заполнено"
    end
  end

  private

  def authors_params
  	params.require(:author).permit(:name, :book_id)
  end
end
