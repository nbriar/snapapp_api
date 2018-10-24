require 'test_helper'

class CustomerAppsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
  end

  test "should get index of account apps" do
    1..3.times do |i|
      CustomerApp.create(name: "App#{i}", auth_account_id: @account.id)
    end

    1..3.times do |i|
      CustomerApp.create(name: "App#{i}", auth_account_id: 0)
    end

    get customer_apps_url, as: :json, headers: auth_header

    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 4, body["customer_apps"].count
  end

  test "should create customer_app" do
    assert_difference('CustomerApp.count') do
      post customer_apps_url, params: { customer_app: { name: "test" } }, as: :json, headers: auth_header
    end

    assert_response 201
  end

  test "should show customer_app" do
    get customer_app_url(@customer_app), as: :json, headers: auth_header
    assert_response :success
  end

  test "should update customer_app" do
    patch customer_app_url(@customer_app), params: { customer_app: { name: "updated" } }, as: :json, headers: auth_header
    assert_response 200
  end

  test "should destroy customer_app" do
    assert_difference('CustomerApp.count', -1) do
      delete customer_app_url(@customer_app), as: :json, headers: auth_header
    end

    assert_response 204
  end
end
