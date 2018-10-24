require 'test_helper'

class CustomerApp::PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
    @app_header = {"X-APP-ID": @customer_app.id}

    @not_my_app = CustomerApp.create(name: 'No App', auth_account_id: @account.id)
    @page = Page.create(title: "TestPage", route: "/testme", customer_app: @customer_app)
  end

  test "should get index of pages for the customer_app" do
    1..3.times do |i|
      Page.create(title: "TestPage#{i}", route: "/testme", customer_app: @not_my_app)
    end

    get customer_app_pages_url(@customer_app), as: :json, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 1, body["pages"].count
    assert_equal @page.id, body["pages"].first["id"]
  end

  test "should create page" do
    assert_difference('Page.count') do
      post customer_app_pages_url(@customer_app), params: { page: { route: '/new-page', title: 'New Page' } }, as: :json, headers: auth_header.merge(@app_header)
    end

    assert_response 201
  end

  test "should show page" do
    get customer_app_page_url(@customer_app, @page), as: :json, headers: auth_header.merge(@app_header)

    body = JSON.parse(response.body)

    assert_response :success
    assert_equal @page.id, body["id"]
  end

  test "should update page" do
    patch customer_app_page_url(@customer_app, @page), params: { page: { route: "/new/route" } }, as: :json, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response 200
    assert_equal "/new/route", body["route"]
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete customer_app_page_url(@customer_app, @page), as: :json, headers: auth_header.merge(@app_header)
    end

    assert_response 204
  end
end
