class V1::UserController < V1Controller
  before_action :authorization, only: [ :show, :update ]
  before_action :set_user

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created
    else
      render json: { message: I18n.t("controllers.v1.user.create.error"), errors: @user.errors },
             status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.expect(user: [ :first_name, :last_name, :middle_name, :email, :password,
                          :password_confirmation ])
  end
end
