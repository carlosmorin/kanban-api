require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_and_belong_to_many :projects }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).case_insensitive }
end
