class ReviewsController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :set_review, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index]

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.create(review_params)
    @review.user_id = current_user.id
    session[:title] = params[:review][:title]
    session[:rate] = params[:review][:rate]
    session[:text_of_review] = params[:review][:text_of_review]
    @title = session[:title]
    @rate = session[:rate]
    @text_of_review = session[:text_of_review]
      if @review.save
        redirect_to @book, notice: 'Thanks for Review. It will be published as soon as Admin will approve it'
      else
        redirect_to book_path(@book, anchor: "form_id"), 
        notice: {title: @title, rate: @rate, text_of_review: @text_of_review},
        alert: @review.errors
      end
  end
 
  def index
    @reviews = Review.all
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :rate, :text_of_review, :book_id, :user_id)
  end

end
