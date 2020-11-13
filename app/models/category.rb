class Category < ApplicationRecord
  validates :name, presence: true
  has_many :issues, inverse_of: :category
end
