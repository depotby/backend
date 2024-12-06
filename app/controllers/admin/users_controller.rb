class Admin::UsersController < AdminController
  before_action -> { check_ability("USER:READ") }, only: %i[index show]
  before_action :set_user, only: %i[show]

  def index
    @users = User.all
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
