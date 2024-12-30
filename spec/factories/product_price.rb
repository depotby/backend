FactoryBot.define do
  factory :product_price do
    product
    amount { rand(0.01..1000000000.00) }
  end
end
