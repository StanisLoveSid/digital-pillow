class Price < ApplicationRecord
  belongs_to :book
  has_many :order_items 
  validates :price, presence: true
  validates :size, presence: true
 
  before_create :currency_convertion

  def currency_convertion
    self[:price] *= Concurrency.convert(1, "USD", "UAH").round
  end
end
