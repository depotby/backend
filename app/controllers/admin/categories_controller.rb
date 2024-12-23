class Admin::CategoriesController < AdminController
  include Paginable
  include Orderable

  before_action -> { check_ability("CATEGORY:READ") }, only: %i[index show]
  before_action -> { check_ability("CATEGORY:CREATE") }, only: %i[create]
  before_action -> { check_ability("CATEGORY:UPDATE") }, only: %i[update]
  before_action -> { check_ability("CATEGORY:DELETE") }, only: %i[destroy]
  before_action :set_category, only: %i[show update destroy]

  def index
    if order_correct?
      @pagination, @categories = paginate(Category.order(order_param => order_direction))
    else
      @pagination, @categories = paginate(Category.all.order(created_at: :desc))
    end
  end

  def show
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.categories.create.errors.creation"),
                     fields: @category.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render :show
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.categories.update.errors.update"),
                     fields: @category.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
  end

  private

  def category_params
    params.expect(category: [ :name, :uri_name ])
  end

  def order_params
    %i[name]
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
