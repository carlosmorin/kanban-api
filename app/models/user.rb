class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
