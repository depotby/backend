FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    middle_name { [ Faker::Name.middle_name, nil ].sample }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    account_type { User.account_types[:regular] }

    factory :employee_without_abilities do
      account_type { User.account_types[:employee] }

      factory :employee_with_all_abilities do
        after(:create) do |user|
          user.roles << create(:role_with_all_abilities)
        end
      end
    end
  end
end
