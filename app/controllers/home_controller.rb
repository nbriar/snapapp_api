class HomeController < ApplicationController
  def index
    render json: {success: "Welcome to TextDepot."}
  end
end
