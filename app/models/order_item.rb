class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order
  belongs_to :price

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :book_present
  before_save :finalize


  def unit_weight
    if persisted?
      self[:unit_weight]
    else
      book.weight
    end
  end

  def total_weight
    unit_weight * quantity
  end

  def total_price
    unit_price * quantity
  end

  private

  def book_present
    if book.nil?
      errors.add(:book, "is not valid or is not active.")
    end
  end

  def finalize
    self[:total_price] = quantity * self[:unit_price]
    self[:total_weight] = quantity * self[:unit_weight]
  end
end
