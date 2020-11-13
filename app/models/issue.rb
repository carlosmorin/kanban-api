class Issue < ApplicationRecord
  belongs_to :user, inverse_of: :issues
  belongs_to :category, inverse_of: :issues
  belongs_to :project, inverse_of: :issues
    
  has_many :comments, inverse_of: :issue
  has_and_belongs_to_many :tags

  validates :subject, :description, :status, :due_date, presence: true

  enum status: %i[pending todo done doing finished]
end
