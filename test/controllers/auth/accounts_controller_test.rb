require 'test_helper'

class Auth::AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auth_account = auth_accounts(:one)
  end

  test "should get index" do
    get auth_accounts_url, as: :json, headers: auth_header
    assert_response :success
  end

  test "should show auth_account" do
    get auth_account_url(@auth_account), as: :json, headers: auth_header
    assert_response :success
  end

  test "should update auth_account" do
    patch auth_account_url(@auth_account), params: { auth_account: {  } }, as: :json, headers: auth_header
    assert_response 200
  end

  # These 2 tests are a little funky because wee changed the way accounts get created
  # An account with the name of the external_user_id is created when we hit the endpoint
  # if it doesn't exist.
  test "should create auth_account" do
    assert_difference('Auth::Account.count', 2) do
      post auth_accounts_url, params: { auth_account: {  } }, as: :json, headers: auth_header
    end

    assert_response 201
  end

  test "should destroy auth_account" do
    assert_difference('Auth::Account.count', 0) do
      delete auth_account_url(@auth_account), as: :json, headers: auth_header
    end

    assert_response 204
  end
end
