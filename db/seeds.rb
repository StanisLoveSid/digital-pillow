require 'ffaker'
require 'carrierwave'

images = [ 'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/190481140X.jpg',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/6528OS.jpg',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/71XeqmFvLwL.jpg',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/9781785289811.png',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/C06035.jpg',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/d9e0ef5f476610f8fd86c9ef930d2ef3.jpg',
           'https://s3-us-west-2.amazonaws.com/stasbookstore/covers/learning-web-design-a-beginners-guide.png' ]

Book.destroy_all
Category.destroy_all
Author.destroy_all
BookAttachment.destroy_all

Category.create! name: "Turbo"
Category.create! name: "New"

Category.find_each do |category|
  rand(34..57).times do |n|
    Book.create!(title: "#{FFaker::Book.title} #{n}",
                 description: FFaker::Book.description.to_s[0..2000],
                 price: rand(9.99..65.99),
                 year_of_publication: rand(2005..2015),
                 materials: FFaker::Lorem.sentence,
                 demensions: rand(3.1..4.5),
                 category: category,
                 aasm_state: "published",
                 quantity: 20)
    BookAttachment.create! remote_photo_url: images[rand(0..6)]
  end
end

Book.find_each do |book|
  book.book_attachments.create! photo: (BookAttachment.find(rand(BookAttachment.first.id..BookAttachment.last.id))).photo	
  book.authors.create! name: FFaker::Name.name, bio: FFaker::Lorem::paragraph(5)
  book.prices.create! price: rand(1..1980), size: "#{FFaker::Book.title}"
end
