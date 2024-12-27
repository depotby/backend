class Admin::CategoryPropertyOptionsController < AdminController
  before_action -> { check_ability("CATEGORY:UPDATE") }
  before_action :set_category, :set_category_property
  before_action :set_category_property_option, only: %i[update destroy]

  def create
    @category_property_option = @category_property.category_property_options
                                                  .new(category_property_option_params)

    if @category_property_option.save
      render :show, status: :created
    else
      error = I18n.t("controllers.admin.category_property_options.create.errors.creation")
      render json: { status: 422, error:, fields: @category_property_option.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @category_property_option.update(category_property_option_params)
      render :show
    else
      error = I18n.t("controllers.admin.category_property_options.update.errors.update")
      render json: { status: 422, error:, fields: @category_property_option.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    @category_property_option.destroy!
  end

  private

  def category_property_option_params
    params.expect(category_property_option: [ :variant ])
  end

  def set_category
    @category = Category.find(params.expect(:category_id))
  end

  def set_category_property
    @category_property = @category.category_properties.find(params.expect(:property_id))
  end

  def set_category_property_option
    @category_property_option = @category_property.category_property_options
                                                  .find(params[:option_id])
  end
end
