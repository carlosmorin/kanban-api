require 'rails_helper'

RSpec.describe Issue, type: :model do
  it { should belong_to :user }
  it { should belong_to :category }
  it { should belong_to :project }
  it { should have_many :comments }
  it { should have_and_belong_to_many :tags }

  it { should validate_presence_of :subject }
  it { should validate_presence_of :description }
  it { should validate_presence_of :status }
  it { should validate_presence_of :due_date }
end
