class Address < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :region, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :street, presence: true
  validates :building, presence: true
end
