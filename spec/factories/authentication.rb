FactoryBot.define do
  factory :authentication do
    user
    access_type { Authentication.access_types[:regular] }
    status { Authentication.statuses[:active] }
    user_agent { Faker::Internet.user_agent }

    factory :admin_authentication_without_abilities do
      association :user, factory: :employee_without_abilities
      access_type { Authentication.access_types[:admin] }

      factory :admin_authentication_with_all_abilities do
        association :user, factory: :employee_with_all_abilities
      end
    end
  end
end
