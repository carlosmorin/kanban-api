FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user
    issue
  end
end
