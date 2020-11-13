FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }

    description { "MyText2" }
  end
end
