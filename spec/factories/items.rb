FactoryBot.define do
  factory :item do
    association :merchant_id, factory: :merchant
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
  end
end
