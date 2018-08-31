class AuthorsController < ApplicationController
  def create
    @book = Book.find(params[:author][:book_id])
    @author = Author.find_by(name: params[:author][:name])
    if @author.nil?
      @book.authors.new(authors_params)
      flash[:success] = "Назву виробника добавлено"
    elsif @author.books.exists? @book
      flash[:success] = "Производитель уже добавлен к этому товару"
    else
      (@author.books << @book)
      flash[:success] = "Назву виробника добавлено"
    end

    if @book.save 
      flash[:success]
      redirect_to @book
    else
      redirect_to @book
      flash[:alert] = "Имя должно быть заполнено"
    end
  end

  def destroy
    @book = Book.find(params[:book][:book_id])
    author = @book.authors.find(params[:book][:id])
    @book.authors.delete(author)
    redirect_to :back, notice: "Виробника видалено успішно"
  end

  private

  def authors_params
  	params.require(:author).permit(:name, :book_id, :id)
  end
end
