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
      render :show, status: :created
    else
      render json: { status: 422,
                     error: I18n.t("controllers.v1.addresses.create.error"),
                     fields: @address.errors },
             status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      render :show
    else
      render json: { status: 422,
                     error: I18n.t("controllers.v1.addresses.update.error"),
                     fields: @address.errors },
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
    params.expect(address: [ :name, :region, :city, :zip, :street, :building, :building_section,
                             :apartment ])
  end
end
