class Book < ApplicationRecord
  mount_uploaders :photos, BookPhotoUploader  
  include AASM

  aasm do
    state :unpublished, initial: true
    state :published

    event :publish do
      transitions from: :unpublished, to: :published
    end
  end 

  def state
   if quantity > 5
   "У наявності"
   elsif quantity > 0 && quantity < 5 
   "Закінчується"
   else
    "Немає у наявності"
   end    
  end 

  paginates_per 4
  belongs_to :user
  belongs_to :category
  has_and_belongs_to_many :authors
  has_many :prices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :book_attachments, dependent: :destroy
  accepts_nested_attributes_for :book_attachments
  has_many :order_items, dependent: :destroy
  default_scope { where(active: true) }

  def self.all_ordered_by_prices_price
    includes(:prices).order('prices.price DESC')
  end

  def self.all_ordered_by_prices_size
    includes(:prices).order('prices.size DESC')
  end

end
