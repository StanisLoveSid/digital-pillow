class BookMailer < ActionMailer::Base
  require "carrierwave"	
  def send_book(users, book)
  	@users = users
  	@book = book
	recipients = @users.collect(&:email).join(", ")
    attachments.inline['logo.png'] = {
      data: File.read(Rails.root.join("public"+"#{@book.book_attachments.first.photo.url(:thumb)}")),
      mime_type: 'image/png'
    }	
    mail(to: recipients, 
       	 from: 'no-reply@podushka.dp.ua',
       	 subject: "Новий товар у нашому магазині #{@book.title} ")  		
  end	
end
