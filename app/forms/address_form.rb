class AddressForm < Rectify::Form
  attribute :first_name,       String
  attribute :last_name,        String
  attribute :address,          String
  attribute :addressing,       String
  attribute :city,             String
  attribute :zipcode,          String
  attribute :phone,            String
  attribute :addressable_type, String
  attribute :addressable_id,   Integer
 

  validates :first_name,
    :last_name,
    :address,
    :addressing,
    :city,
    :zipcode,
    :phone,
    :addressable_type,
    presence: true

  validates :phone, format: { with: /\A\+\d{12}\z/,
   message: "is invalid. Example : +380971112233"}
end
