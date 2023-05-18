FactoryBot.define do
  factory :comment do
    association :user
    association :post
    body { 'Lorem ipsum' }
  end
end
