class Admin::RolesController < AdminController
  include Paginable

  before_action -> { check_ability("ROLE:READ") }, only: %i[index show]
  before_action -> { check_ability("ROLE:CREATE") }, only: %i[create]
  before_action -> { check_ability("ROLE:UPDATE") }, only: %i[update]
  before_action -> { check_ability("ROLE:DELETE") }, only: %i[destroy]
  before_action :set_role, only: %i[show update destroy]

  def index
    @pagination, @roles = paginate(Role.all)
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      render :show, status: :created
    else
      render json: { message: I18n.t("controllers.admin.roles.create.errors.creation"),
                     errors: @role.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @role.update(role_params)
      render :show
    else
      render json: { message: I18n.t("controllers.admin.roles.update.errors.update"),
                     errors: @role.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy!
  end

  private

  def role_params
    params.expect(role: [ :name ])
  end

  def set_role
    @role = Role.find(params.expect(:id))
  end
end
