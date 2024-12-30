class ProductPrice < ApplicationRecord
  belongs_to :product

  validates :amount, presence: true, numericality: { greater_than: 0 }
end
