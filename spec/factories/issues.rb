FactoryBot.define do
  factory :issue do
    subject { "MyString" }
    description { "MyText" }
    status { 1 }
    due_date { "2020-11-13 00:19:26" }
    user { nil }
    category { nil }
  end
end
