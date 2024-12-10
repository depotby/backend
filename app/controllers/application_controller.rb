class ApplicationController < ActionController::API
  def authorization
    Current.authentication = authentications_scope.find_by_token_for(:authorization,
                                                                     authorization_header)

    return if Current.user

    render json: { status: 401,
                   error: I18n.t("controllers.application.authorization.unauthorized") },
           status: :unauthorized
  end

  def authorization_header
    request.headers["Authorization"]
  end
end
