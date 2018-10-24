class HealthcheckController < ApplicationController
  def index
    usercount = User.count # Just need to ping the database
    render json: {success: {
      message: "Everything is running",
      usercount: usercount
      }}
  end
end
