class Product < ApplicationRecord
  belongs_to :category
  has_many :product_prices, dependent: :destroy
  has_one :latest_product_price, -> { latest }, class_name: "ProductPrice"

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true
end
