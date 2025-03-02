class V1::AuthenticationsController < V1Controller
  include Authenticatable

  before_action :authorization, only: [ :index, :destroy ]
  before_action :set_authentication, only: [ :destroy ]

  private

  def access_type
    :regular
  end

  def authentication_allowed?
    !!@user
  end
end
