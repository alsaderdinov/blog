FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@test.com" }
    password { '1234Abc!' }
    password_confirmation { '1234Abc!' }
  end
end
