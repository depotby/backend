class Admin::UsersController < AdminController
  include Paginable
  include Orderable

  before_action -> { check_ability("USER:READ") }, only: %i[index show]
  before_action :set_user, only: %i[show]

  def index
    if order_correct?
      @pagination, @users = paginate(User.order(order_param => order_direction))
    else
      @pagination, @users = paginate(User.all.order(created_at: :desc))
    end
  end

  def show
  end

  private

  def order_params
    %i[email first_name last_name account_type created_at updated_at]
  end

  def set_user
    @user = User.find(params.expect(:id))
  end
end
