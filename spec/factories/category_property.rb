FactoryBot.define do
  factory :category_property do
    sequence(:name) { |n| "#{%w[Brand Weight Width Height Color].sample} #{n}" }

    category
    uri_name { name.parameterize }
  end
end
