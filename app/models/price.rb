class Price < ApplicationRecord
  belongs_to :book
  has_many :order_items 
  validates :price, presence: true
  validates :size, presence: true
end
