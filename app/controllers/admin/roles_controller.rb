class Admin::RolesController < AdminController
  include Paginable

  before_action -> { check_ability("ROLE:READ") }, only: %i[index show]
  before_action :set_role, only: %i[show]

  def index
    @pagination, @roles = paginate(Role.all)
  end

  def show
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end
end
