class V1::UserController < V1Controller
  before_action :authorization, only: [ :show, :update ]
  before_action :set_user

  def show
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.v1.user.create.error"),
                     fields: @user.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_update_params)
      render :show
    else
      render json: { status: 422,
                     error: I18n.t("controllers.v1.user.update.error"),
                     fields: @user.errors },
             status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def user_create_params
    params.expect(user: [ :first_name, :last_name, :middle_name, :email, :password,
                          :password_confirmation ])
  end

  def user_update_params
    params.expect(user: [ :first_name, :last_name, :middle_name ])
  end
end
