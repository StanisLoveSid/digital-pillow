class Author < ApplicationRecord
  has_and_belongs_to_many :books
  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }
end
