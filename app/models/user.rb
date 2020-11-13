class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :projects
  has_many :issues, inverse_of: :user
end
