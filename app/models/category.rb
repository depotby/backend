class Category < ApplicationRecord
  has_many :category_properties, dependent: :destroy
  has_many :category_property_options, through: :category_properties
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true
end
