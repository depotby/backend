class Admin::CategoryPropertiesController < AdminController
  before_action -> { check_ability("CATEGORY:READ") }, only: %i[index show]
  before_action -> { check_ability("CATEGORY:UPDATE") }, only: %i[create update destroy]
  before_action :set_category
  before_action :set_category_property, only: %i[show update destroy]

  def index
    @category_properties = @category.category_properties.includes(:category_property_options)
  end

  def create
    @category_property = @category.category_properties.new(category_property_params)

    if @category_property.save
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.category_properties.create.errors.creation"),
                     fields: @category_property.errors },
             status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @category_property.update(category_property_params)
      render :show
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.category_properties.update.errors.update"),
                     fields: @category_property.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    @category_property.destroy!
  end

  private

  def category_property_params
    params.expect(category_property: [ :name, :uri_name ])
  end

  def set_category
    @category = Category.find(params.expect(:category_id))
  end

  def set_category_property
    @category_property = @category.category_properties.find(params.expect(:property_id))
  end
end
