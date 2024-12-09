class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :uri_name, presence: true, uniqueness: true
end
