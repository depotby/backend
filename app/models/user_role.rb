class UserRole < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :role
end
