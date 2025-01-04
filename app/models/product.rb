class Product < ApplicationRecord
  belongs_to :category
  has_many :product_prices, dependent: :destroy

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true

  def latest_product_price
    product_prices.find_by(latest: true)
  end
end
