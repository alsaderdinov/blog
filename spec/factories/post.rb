FactoryBot.define do
  factory :post do
    association :user
    title { 'MyTitle' }
    body { 'Lorem ipsum' }
  end
end
