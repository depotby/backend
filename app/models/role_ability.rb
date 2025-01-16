class RoleAbility < ApplicationRecord
  belongs_to :role, touch: true
  belongs_to :ability
end
