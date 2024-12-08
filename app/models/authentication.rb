class Authentication < ApplicationRecord
  TTL = Rails.configuration.application_settings[:authentication]

  belongs_to :user

  enum :status, inactive: 0, active: 1
  enum :access_type, regular: 0, admin: 1

  generates_token_for :authorization, expires_in: TTL[:access_ttl] do
    [ status ]
  end

  generates_token_for :refresh, expires_in: TTL[:refresh_ttl] do
    [ status ]
  end

  def browser
    @browser ||= Browser.new(user_agent)
  end
end
