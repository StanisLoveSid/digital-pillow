class CategoriesController < ApplicationController

  authorize_resource 

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    @category.save
    redirect_to @category
  end

  def optimise(array)
    Kaminari.paginate_array(array).page(params[:page]).per(12)
  end 

  def index
    prices =[]
    Book.all.each do |book|
      prices << book.prices.first
    end
    @books = Book.all.published
    @categories = Category.all
    if params[:filter] == 'from A to Z'
      @sorted_books = optimise(@books.sort_by(&:title))
      @filter_name = 'Назва: А-Я'
    elsif params[:filter] == 'from Z to A'
      @sorted_books = optimise(@books.sort_by(&:title).reverse)
      @filter_name = 'Назва: Я-А'
    elsif params[:filter] == 'All'
      @sorted_books = optimise(Book.all)
      @filter_name = 'Усі'
    elsif params[:filter] == 'popular'
      @sorted_books = optimise(@books.sort_by(&:pick_times).reverse)
      @filter_name = 'Спочатку популярні'
    elsif params[:filter] == 'newest'
      @sorted_books = optimise(@books.order("created_at DESC"))
      @filter_name = 'Спочатку нові'
    elsif params[:filter] == 'from low to high'
      @sorted_books = optimise(@books.all_ordered_by_prices_price.reverse)
      @filter_name = 'Ціна: від низької до високої'
    elsif params[:filter] == 'from high to low'
      @sorted_books = optimise(@books.all_ordered_by_prices_price)
      @filter_name = 'Ціна: від високої до низької'
    elsif params[:filter] == 'Size from smaller to bigger'
      @sorted_books = optimise(@books.all_ordered_by_prices_size.reverse)
      @filter_name = 'Розмір: від малого до великого'
    elsif params[:filter] == 'Size from bigger to smaller'
      @sorted_books = optimise(@books.all_ordered_by_prices_size)
      @filter_name = 'Розмір: від великого до малого'      
    else
      @sorted_books = optimise(@books)
      @filter_name = "Оберіть сортування"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @books = @category.books.published
    if params[:filter] == 'from A to Z'
      @sorted_books = optimise(@books.sort_by(&:title))
      @filter_name = 'Назва: А-Я'
    elsif params[:filter] == 'from Z to A'
      @sorted_books = optimise(@books.sort_by(&:title).reverse)
      @filter_name = 'Назва: Я-А'
    elsif params[:filter] == 'All'
      @sorted_books = optimise(Book.all)
      @filter_name = 'Усі'
    elsif params[:filter] == 'popular'
      @sorted_books = optimise(@books.sort_by(&:pick_times).reverse)
      @filter_name = 'Спочатку популярні'
    elsif params[:filter] == 'newest'
      @sorted_books = optimise(@books.order("created_at DESC"))
      @filter_name = 'Спочатку нові'
    elsif params[:filter] == 'from low to high'
      @sorted_books = optimise(@books.all_ordered_by_prices_price.reverse)
      @filter_name = 'Ціна: від низької до високої'
    elsif params[:filter] == 'from high to low'
      @sorted_books = optimise(@books.all_ordered_by_prices_price)
      @filter_name = 'Ціна: від високої до низької'
    elsif params[:filter] == 'Size from smaller to bigger'
      @sorted_books = optimise(@books.all_ordered_by_prices_size.reverse)
      @filter_name = 'Розмір: від малого до великого' 
    elsif params[:filter] == 'Size from bigger to smaller'
      @sorted_books = optimise(@books.all_ordered_by_prices_size)
      @filter_name = 'Розмір: від великого до малого'      
    else
      @sorted_books = optimise(@books)
      @filter_name = "Оберіть сортування"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to root_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :id)
  end

end
