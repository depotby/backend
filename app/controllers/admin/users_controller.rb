class Admin::UsersController < AdminController
  include Paginable
  include Orderable

  before_action -> { check_ability("USER:READ") }, only: %i[index show]
  before_action :set_user, only: %i[show]

  def index
    if ordering_correct?
      @pagination, @users = paginate(User.order(order_column: order_direction))
    else
      @pagination, @users = paginate(User.all)
    end
  end

  def show
  end

  private

  def orderable_params
    %i[email first_name last_name account_type created_at updated_at]
  end

  def set_user
    @user = User.find(params[:id])
  end
end
