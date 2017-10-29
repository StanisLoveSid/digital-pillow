class SendMailsJob < ApplicationJob
  queue_as :default

  def perform(book)
  	@book = book
    BookMailer.send_book(User.all, @book).deliver
  end
end
