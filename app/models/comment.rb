class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user, inverse_of: :comments
  belongs_to :issue, inverse_of: :comments
end
