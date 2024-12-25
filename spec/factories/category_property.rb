FactoryBot.define do
  factory :category_property do
    sequence(:name) { |n| "#{%w[Brand Weight Width Height Color Aroma].sample} #{n}" }

    category
    uri_name { name.parameterize }

    transient do
      options_count { 1 }
    end

    after(:create) do |category_property, evaluator|
      create_list(:category_property_option, evaluator.options_count, category_property:)
    end
  end
end
