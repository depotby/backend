module Authenticatable
  extend ActiveSupport::Concern

  def index
    @authentications = Current.user.authentications.where(access_type:)
    render template: "concerns/authenticatable/index"
  end

  def create
    @user = User.find_by(email: authentication_params[:email])

    if authentication_allowed? && @user.authenticate(authentication_params[:password])
      @authentication = @user.authentications.create(user_agent:, access_type:)
      render template: "concerns/authenticatable/create", status: :created
    else
      render json: { message: I18n.t("controllers.concerns.authenticatable.create.error") },
             status: :unauthorized
    end
  end

  def refresh
    authentication = Authentication.where(access_type:).find_by_token_for(:refresh, params[:token])
    @user = authentication&.user

    if authentication_allowed?
      @authentication = @user.authentications.create(user_agent:, access_type:)
      authentication.destroy
      render template: "concerns/authenticatable/create", status: :created
    else
      render json: { message: I18n.t("controllers.concerns.authenticatable.refresh.error") },
             status: :unauthorized
    end
  end

  def destroy
    @authentication.inactive!
  end

  private

  def user_agent
    request.user_agent
  end

  def set_authentication
    @authentication = Current.authentication
  end

  def authentication_params
    params.expect(user: [ :email, :password ])
  end
end
