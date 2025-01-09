class Admin::UsersController < AdminController
  include Paginable
  include Orderable

  before_action -> { check_ability("USER:READ") }, only: %i[index show]
  before_action -> { check_ability("USER_TYPE:UPDATE") }, only: %i[switch_type]
  before_action :set_user, only: %i[show switch_type]

  def index
    if order_correct?
      @pagination, @users = paginate(User.order(order_param => order_direction))
    else
      @pagination, @users = paginate(User.all.order(created_at: :desc))
    end
  end

  def show
  end

  def switch_type
    if @user.regular?
      @user.employee!
    else
      ActiveRecord::Base.transaction do
        @user.regular!
        @user.authentications.active.update_all(status: :inactive)
      end
    end

    render :show
  end

  private

  def order_params
    %i[email first_name last_name account_type created_at updated_at]
  end

  def set_user
    @user = User.find(params.expect(:id))
  end
end
