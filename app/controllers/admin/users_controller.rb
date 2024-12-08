class Admin::UsersController < AdminController
  include Paginable

  before_action -> { check_ability("USER:READ") }, only: %i[index show]
  before_action :set_user, only: %i[show]

  def index
    @pagination, @users = paginate(User.all)
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
