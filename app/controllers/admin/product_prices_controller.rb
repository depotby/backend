class Admin::ProductPricesController < AdminController
  before_action -> { check_ability("PRODUCT:UPDATE") }
  before_action :set_product

  def create
    @product_price = @product.product_prices.new(price_params)

    if same_amount?
      @product_price = @product.current_product_price
      render :show
    elsif @product_price.save
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.admin.product_price.create.errors.creation"),
                     fields: @product_price.errors },
             status: :unprocessable_entity
    end
  end

  private

  def same_amount?
    @product.current_product_price&.amount == @product_price.amount
  end

  def price_params
    params.expect(product_price: [ :amount ])
  end

  def set_product
    @product = Product.find(params.expect(:id))
  end
end
