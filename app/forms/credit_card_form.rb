class CreditCardForm < Rectify::Form
  include ActiveModel::Validations
  attr_accessor :number

  attribute :first_name, String
  attribute :number,    String
  attribute :cvv,       Integer
  attribute :user_id,   Integer
  attribute :order_id,  Integer
  attribute :expiration_date, String

  validates :number, presence: true, credit_card_number: true

  validates :cvv,
    presence: true,
    numericality: { only_integer: true },
    length: { is: 3 }

  validates :first_name,
    presence: true

  validates :expiration_date, presence: true,
    length: { maximum: 5 }

end