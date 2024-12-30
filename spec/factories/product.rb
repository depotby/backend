FactoryBot.define do
  factory :product do
    category
    name { Faker::Commerce.unique.product_name }
    uri_name { name.parameterize }

    after(:create) do |product|
      create(:product_price, product:)
    end
  end
end
