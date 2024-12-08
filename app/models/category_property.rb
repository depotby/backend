class CategoryProperty < ApplicationRecord
  belongs_to :category
  has_many :category_property_options, dependent: :destroy

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true
end
