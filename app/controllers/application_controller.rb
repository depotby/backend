class ApplicationController < ActionController::API
  before_action :set_locale

  private

  def set_locale
    I18n.locale = locale_header if I18n.locale_available?(locale_header)
  end

  def authorization
    Current.authentication = authentications_scope.find_by_token_for(:authorization,
                                                                     authorization_header)

    return if Current.user

    render json: { status: 401,
                   error: I18n.t("controllers.application.authorization.unauthorized") },
           status: :unauthorized
  end

  def locale_header
    request.headers["Accept-Language"]
  end

  def authorization_header
    request.headers["Authorization"]
  end
end
