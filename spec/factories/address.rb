FactoryBot.define do
  factory :address do
    user
    name { Faker::Address.unique.community }
    region { Faker::Address.state }
    city { Faker::Address.city }
    zip { Faker::Address.zip }
    street { Faker::Address.street_name }
    building { Faker::Address.building_number }
    building_section { [ 'A', 'B', 'C', 'D', nil ].sample }
    apartment { (1..9).to_a.push(nil).sample }
  end
end
