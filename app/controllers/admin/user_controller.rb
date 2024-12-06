class Admin::UserController < AdminController
  before_action :authorization
  before_action :set_user

  def show
    @abilities = @user.abilities_names
  end

  private

  def set_user
    @user = Current.user
  end
end
