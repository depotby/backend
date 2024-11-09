class User < ApplicationRecord
  has_secure_password
  has_many :authentications, dependent: :destroy

  normalizes :email, with: ->(email) { email.downcase }

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP,
                      message: I18n.t("models.user.validations.email.wrong_email_format") }
end
