class CategoryPropertyOption < ApplicationRecord
  belongs_to :category_property, touch: true

  validates :variant, presence: true,
            uniqueness: { case_sensitive: false, scope: :category_property }
end
