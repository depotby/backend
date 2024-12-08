class ProductCategoryPropertyOption < ApplicationRecord
  belongs_to :product
  belongs_to :category_property_option
end
