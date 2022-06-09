FactoryBot.define do
  factory :refresh_token do
    user { nil }
    token { 'MyString' }
  end
end
