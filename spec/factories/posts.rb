FactoryBot.define do
  factory :post do
    title { 'tester' }

    content { 'hello world!' }

    association :user
  end
end
