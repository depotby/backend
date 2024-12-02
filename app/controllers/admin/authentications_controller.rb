class Admin::AuthenticationsController < AdminController
  include Authenticatable

  skip_before_action :authorization, only: [ :create, :refresh ]
  before_action :set_authentication, only: [ :destroy ]

  private

  def access_type
    :admin
  end

  def authentication_allowed?
    !!@user&.employee?
  end
end
