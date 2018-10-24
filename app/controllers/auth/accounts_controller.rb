class Auth::AccountsController < PrivateController
  before_action :set_auth_account, only: [:show, :update, :destroy]

  # GET /auth/accounts
  # GET /auth/accounts.json
  def index
    @auth_accounts = Auth::Account.all
  end

  # GET /auth/accounts/1
  # GET /auth/accounts/1.json
  def show
  end

  # POST /auth/accounts
  # POST /auth/accounts.json
  def create
    @auth_account = Auth::Account.new(auth_account_params)

    if @auth_account.save
      render :show, status: :created, location: @auth_account
    else
      render json: @auth_account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /auth/accounts/1
  # PATCH/PUT /auth/accounts/1.json
  def update
    if @auth_account.update(auth_account_params)
      render :show, status: :ok, location: @auth_account
    else
      render json: @auth_account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /auth/accounts/1
  # DELETE /auth/accounts/1.json
  def destroy
    @auth_account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auth_account
      @auth_account = Auth::Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auth_account_params
      params.fetch(:auth_account, {})
    end
end
