class Ability < ApplicationRecord
  ABILITIES = %w[USER:READ
                 USER:UPDATE
                 ROLE:CREATE
                 ROLE:READ
                 ROLE:UPDATE
                 ROLE:DELETE
                 CATEGORY:CREATE
                 CATEGORY:READ
                 CATEGORY:UPDATE
                 CATEGORY:DELETE
                 CATEGORY_PROPERTY:CREATE
                 CATEGORY_PROPERTY:READ
                 CATEGORY_PROPERTY:UPDATE
                 CATEGORY_PROPERTY:DELETE].freeze

  has_many :role_abilities, dependent: :destroy
  has_many :roles, through: :role_abilities

  validates :name, presence: true, uniqueness: true

  def self.available
    ABILITIES
  end
end
