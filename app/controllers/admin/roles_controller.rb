class Admin::RolesController < AdminController
  include Paginable

  before_action -> { check_ability("ROLE:READ") }, only: %i[index show]
  before_action -> { check_ability("ROLE:CREATE") }, only: %i[create]
  before_action -> { check_ability("ROLE:UPDATE") }, only: %i[update switch_ability]
  before_action -> { check_ability("ROLE:DELETE") }, only: %i[destroy]
  before_action :set_role, only: %i[show update destroy switch_ability]

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

  def switch_ability
    ability = Ability.find_by(name: switch_ability_params)

    unless ability
      return render json: {
        message: I18n.t("controllers.admin.roles.switch_ability.errors.unknown_ability")
      }, status: :unprocessable_entity
    end

    if @role.abilities.exists?(ability.id)
      @role.abilities.destroy(ability)
    else
      @role.abilities << ability
    end

    render :show
  end

  private

  def role_params
    params.expect(role: [ :name ])
  end

  def switch_ability_params
    params.expect(:ability)
  end

  def set_role
    @role = Role.find(params.expect(:id))
  end
end
