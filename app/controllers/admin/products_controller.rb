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
      @pagination, @products = paginate(Product.left_joins(:latest_product_price)
                                               .order(order_by_price)
                                               .includes(:latest_product_price))
    elsif order_correct?
      @pagination, @products = paginate(Product.order(order_param => order_direction)
                                               .includes(:latest_product_price))
    else
      @pagination, @products = paginate(Product.order(created_at: :desc)
                                               .includes(:latest_product_price))
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

  def order_by_price
    "product_prices.amount #{order_direction} NULLS #{order_direction == :ASC ? "FIRST" : "LAST"}"
  end

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
