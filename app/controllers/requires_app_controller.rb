class RequiresAppController < ApplicationController
  include Secured

  attr_accessor :active_app

  before_action :set_app

  private

  def set_app
    @active_app ||= CustomerApp.find(request.headers['X-APP-ID'])
  rescue ActiveRecord::RecordNotFound
    return head 404
  end

  def app_id
    @active_app.id
  end
end
