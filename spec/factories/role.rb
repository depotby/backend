FactoryBot.define do
  factory :role do
    name { Faker::Company.unique.department }

    factory :role_without_abilities do
      abilities { [] }
    end

    factory :role_with_all_abilities do
      after(:create) do |role|
        Ability.available.each do |ability_name|
          ability = Ability.find_or_create_by(name: ability_name)
          role.abilities << ability
        end
      end
    end
  end
end
