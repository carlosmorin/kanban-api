class Project < ApplicationRecord
  validates :name, presence: true
  has_and_belongs_to_many :users
  has_many :issues, inverse_of: :project
end
