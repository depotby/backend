class ApplicationController < ActionController::API
  around_action :switch_locale

  private

  def switch_locale(&action)
    locale = I18n.locale_available?(locale_header) ? locale_header : I18n.default_locale
    I18n.with_locale(locale, &action)
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
