class Issue < ApplicationRecord
  belongs_to :user, inverse_of: :issues
  belongs_to :category, inverse_of: :issues
  belongs_to :project, inverse_of: :issues
  
  validates :subject, :description, :status, :due_date, presence: true
  has_many :comments, inverse_of: :issue

  enum status: %i[pending todo done doing finished]
end
