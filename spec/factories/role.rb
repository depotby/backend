FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "#{Faker::Company.department} #{n}" }

    factory :role_without_abilities do
      abilities { [] }
    end

    factory :role_with_all_abilities do
      abilities { Ability.all }
    end
  end
end
