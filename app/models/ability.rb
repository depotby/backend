class Ability < ApplicationRecord
  ABILITIES = %w[USER:READ
                 USER:UPDATE
                 USER_TYPE:UPDATE
                 ROLE:CREATE
                 ROLE:READ
                 ROLE:UPDATE
                 ROLE:DELETE
                 CATEGORY:CREATE
                 CATEGORY:READ
                 CATEGORY:UPDATE
                 CATEGORY:DELETE
                 PRODUCT:CREATE
                 PRODUCT:READ
                 PRODUCT:UPDATE
                 PRODUCT:DELETE].freeze

  has_many :role_abilities, dependent: :destroy
  has_many :roles, through: :role_abilities

  validates :name, presence: true, uniqueness: true

  def self.available
    ABILITIES
  end
end
