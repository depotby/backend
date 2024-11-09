class Ability < ApplicationRecord
  has_many :role_abilities, dependent: :destroy
  has_many :roles, through: :role_abilities
end
