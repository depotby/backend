class ApplicationController < ActionController::API
  private

  def authorization
    Current.authentication = Authentication.find_by_token_for(:authorization, authorization_header)

    return if Current.user

    render json: { message: I18n.t("controllers.v1.authorization.authorization_required") },
           status: :unauthorized
  end

  def authorization_header
    request.headers["Authorization"]
  end
end
