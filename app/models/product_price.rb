class ProductPrice < ApplicationRecord
  belongs_to :product

  validates :amount, presence: true, numericality: { greater_than: 0 }

  before_save :unset_previous_latest

  scope :latest, -> { where(latest: true) }

  private

  def unset_previous_latest
    self.class.where(product_id: product_id).lock.update_all(latest: false)
  end
end
