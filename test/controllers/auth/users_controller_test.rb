require 'test_helper'

class Auth::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_user = Auth::User.create(external_id: external_user_id)
  end

  test "should create auth_user" do
    assert_difference('Auth::User.count') do
      post auth_users_url, params: { auth_user: { external_id: 'someexternalid' } }, as: :json, headers: auth_header
    end

    assert_response 201
    user = Auth::User.find_by(external_id: 'someexternalid')
    assert user.external_id.present?
  end

  test "should show auth_user" do
    get auth_user_url(@auth_user), as: :json, headers: auth_header
    assert_response :success
  end

  test "should update auth_user" do
    patch auth_user_url(@auth_user), params: { auth_user: { email: "test2@test.com" } }, as: :json, headers: auth_header
    assert_response 200
  end

  test "should destroy auth_user" do
    assert_difference('Auth::User.count', -1) do
      delete auth_user_url(@auth_user), as: :json, headers: auth_header
    end

    assert_response 204
  end
end
