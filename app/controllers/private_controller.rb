class PrivateController < ApplicationController
  include Secured

  attr_accessor :active_user, :active_account

  before_action :set_user

  private
  def set_user
    @active_user = UserCreator.find_or_create(external_id: @external_user_id)
    return head 401 unless @active_user

    @active_account = @active_user.account
  end
end
