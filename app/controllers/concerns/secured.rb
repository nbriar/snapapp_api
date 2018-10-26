require "#{Rails.root.join('lib', 'json_web_token')}"

module Secured
  extend ActiveSupport::Concern
  attr_accessor :external_user_id

  included do
    before_action :authenticate_request!
  end

  private

  def authenticate_request!
    payload = auth_token
    @external_user_id = payload[0]["sub"]

  rescue JWT::VerificationError, JWT::DecodeError => e
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    ::JsonWebToken.verify(http_token)
  end
end
