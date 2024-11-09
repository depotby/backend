class Authentication < ApplicationRecord
  belongs_to :user

  enum :status, inactive: 0, active: 1

  generates_token_for :authorization, expires_in: 5.minutes do
    [ status ]
  end

  generates_token_for :refresh, expires_in: 1.month do
    [ status ]
  end

  def browser
    @browser ||= Browser.new(user_agent)
  end
end
