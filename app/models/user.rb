class User < ApplicationRecord
  has_secure_password
  has_many :authentications, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :abilities, through: :roles

  normalizes :email, with: ->(email) { email.downcase }

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP,
                      message: I18n.t("models.user.validations.email.wrong_email_format") }
end
