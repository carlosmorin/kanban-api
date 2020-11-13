FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Category#{n}" }
    email { "jose@mail.com" }
  end
end
