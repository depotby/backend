class V1::AuthenticationsController < V1Controller
  before_action :authorization, only: [ :index, :destroy ]
  before_action :set_authentication, only: [ :destroy ]

  def index
    @authentications = Current.user.authentications
  end

  def create
    Rails.logger.info params.inspect
    user = User.find_by(email: authentication_params[:email])

    if user&.authenticate(authentication_params[:password])
      @authentication = user.authentications.create(user_agent:)
    else
      render json: { message: I18n.t("controllers.v1.authentications.create.error") },
             status: :unauthorized
    end
  end

  def refresh
    authentication = Authentication.find_by_token_for(:refresh, params[:token])

    if authentication
      @authentication = authentication.user.authentications.create(user_agent:)
      authentication.destroy
      render :create
    else
      render json: { message: I18n.t("controllers.v1.authentications.refresh.error") },
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

  def refresh_token
  end

  def set_authentication
    @authentication = Current.authentication
  end

  def authentication_params
    params.expect(user: [ :email, :password ])
  end
end
