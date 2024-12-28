class CategoryPropertyOption < ApplicationRecord
  belongs_to :category_property

  validates :variant, presence: true,
            uniqueness: { case_sensitive: false, scope: :category_property }
end
