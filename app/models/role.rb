class Role < ApplicationRecord
  has_many :role_abilities, dependent: :destroy
  has_many :abilities, through: :role_abilities

  validates :name, presence: true, uniqueness: true
end
