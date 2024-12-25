FactoryBot.define do
  factory :category_property_option do
    sequence(:variant) { |n| "#{%w[Apple Orange Mango 0.5l 1l 2l 3l].sample} #{n}" }

    category_property
  end
end
