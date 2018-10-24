class CustomerAppsController < PrivateController
  before_action :set_customer_app, only: [:show, :update, :destroy]

  # GET /customer_apps
  # GET /customer_apps.json
  def index
    @customer_apps = CustomerApp.for_account(active_account)
  end

  # GET /customer_apps/1
  # GET /customer_apps/1.json
  def show
  end

  # POST /customer_apps
  # POST /customer_apps.json
  def create
    @customer_app = CustomerApp.new(customer_app_params)
    @customer_app.auth_account_id = active_account.id

    if @customer_app.save
      render :show, status: :created, location: @customer_app
    else
      render json: @customer_app.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customer_apps/1
  # PATCH/PUT /customer_apps/1.json
  def update
    if @customer_app.update(customer_app_params)
      render :show, status: :ok, location: @customer_app
    else
      render json: @customer_app.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customer_apps/1
  # DELETE /customer_apps/1.json
  def destroy
    @customer_app.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_app
      @customer_app = CustomerApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_app_params
      params.require(:customer_app).permit(:name)
    end
end
