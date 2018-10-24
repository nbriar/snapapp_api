class Auth::UsersController < PrivateController
  before_action :set_auth_user, only: [:show, :update, :destroy]

  # GET /auth/users/1
  # GET /auth/users/1.json
  def show
  end

  # POST /auth/users
  # POST /auth/users.json
  def create
    # Should pass in external_id to link to auth system
    @auth_user = Auth::User.find_or_initialize_by(auth_user_params)

    if @auth_user.save
      render :show, status: :created, location: @auth_user
    else
      render json: @auth_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /auth/users/1
  # PATCH/PUT /auth/users/1.json
  def update
    if @auth_user.update(auth_user_params)
      render :show, status: :ok, location: @auth_user
    else
      render json: @auth_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /auth/users/1
  # DELETE /auth/users/1.json
  def destroy
    @auth_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auth_user
      @auth_user = Auth::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def auth_user_params
      params.require(:auth_user).permit(:external_id, :email)
    end
end
