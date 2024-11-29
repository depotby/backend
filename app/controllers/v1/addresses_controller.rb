class V1::AddressesController < V1Controller
  before_action :authorization
  before_action :set_address, only: [ :show, :update, :destroy ]

  def index
    @addresses = Current.user.addresses
  end

  def show
  end

  def create
    @address = Current.user.addresses.new(address_params)

    if @address.save
      render :show, status: :created, location: @address
    else
      render json: { message: I18n.t("controllers.v1.addresses.create.error"),
                     errors: @address.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render :show, status: :ok, location: @address
    else
      render json: { message: I18n.t("controllers.v1.addresses.update.error"),
                     errors: @address.errors },
             status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy!
  end

  private

  def set_address
    @address = Current.user.addresses.find(params.expect(:id))
  end

  def address_params
    params.expect(address: [ :name, :region ])
  end
end
