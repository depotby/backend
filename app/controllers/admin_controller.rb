class AdminController < ApplicationController
  before_action :authorization

  private

  def check_ability(name)
    return if Current.user.able?(name)

    render json: { message: I18n.t("controllers.admin.check_ability.errors.not_allowed") },
           status: :forbidden
  end
end
