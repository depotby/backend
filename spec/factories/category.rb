FactoryBot.define do
  factory :category do
    name { Faker::Commerce.unique.department }
    uri_name { name.parameterize }
  end
end
