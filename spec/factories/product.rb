FactoryBot.define do
  factory :product do
    category
    name { Faker::Commerce.unique.product_name }
    uri_name { name.parameterize }
  end
end
