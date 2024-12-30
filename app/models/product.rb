class Product < ApplicationRecord
  belongs_to :category
  has_many :product_prices, dependent: :destroy

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true

  def current_product_price
    if product_prices.loaded?
      product_prices.max_by(&:created_at)
    else
      product_prices.order(created_at: :desc).first
    end
  end
end
