class AdminController < ApplicationController
  before_action :authorization

  private

  def check_ability(name)
    return if Current.user.able?(name)

    render json: { status: 403,
                   error: I18n.t("controllers.admin.check_ability.errors.forbidden") },
           status: :forbidden
  end

  def authentications_scope
    Authentication.admin
  end
end
