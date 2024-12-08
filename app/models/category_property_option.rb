class CategoryPropertyOption < ApplicationRecord
  belongs_to :category_property

  validates :variant, presence: true
end
