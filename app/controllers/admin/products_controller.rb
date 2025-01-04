class Admin::ProductsController < AdminController
  include Paginable
  include Orderable

  before_action -> { check_ability("PRODUCT:READ") }, only: %i[index show]
  before_action -> { check_ability("PRODUCT:CREATE") }, only: %i[create]
  before_action -> { check_ability("PRODUCT:UPDATE") }, only: %i[update]
  before_action -> { check_ability("PRODUCT:DELETE") }, only: %i[destroy]
  before_action :set_product, only: %i[show update destroy]

  def index
    if order_correct? && (order_param == :price)
      filter_rule = "product_prices.latest IS NULL OR product_prices.latest = true"
      nulls_position = order_direction == :ASC ? "FIRST" : "LAST"
      order = "product_prices.amount #{order_direction} NULLS #{nulls_position}"
      @pagination, @products = paginate(Product.left_joins(:product_prices)
                                               .where(filter_rule)
                                               .order(order)
                                               .includes(:product_prices))
    elsif order_correct?
      @pagination, @products = paginate(Product.order(order_param => order_direction)
                                               .includes(:product_prices))
    else
      @pagination, @products = paginate(Product.order(created_at: :desc)
                                               .includes(:product_prices))
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.products.create.errors.creation"),
                     fields: @product.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @product.update(product_params)
      render :show
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.products.update.errors.update"),
                     fields: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy!
  end

  private

  def order_params
    %i[name uri_name price created_at updated_at]
  end

  def set_product
    @product = Product.find(params.expect(:id))
  end

  def product_params
    params.expect(product: [ :category_id, :name, :uri_name ])
  end
end
