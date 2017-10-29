class BookMailer < ActionMailer::Base
  require "carrierwave"	
  def send_book(users, book)
  	@users = users
  	@book = book
	recipients = @users.collect(&:email).join(", ")
    attachments.inline['logo.png'] = {
      data: File.read(Rails.root.join("public"+"#{@book.photos.first.url(:thumb)}")),
      mime_type: 'image/png'
    }	
    mail(to: recipients, 
       	 from: 'forumjankenpon@gmail.com',
       	 subject: "New product in our store #{@book.title} ")  		
  end	
end