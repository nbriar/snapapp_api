require 'test_helper'

class ComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'components controller app', auth_account_id: @account.id)
    @app_header = {"X-APP-ID": @customer_app.id}

    @collection = ::CollectionCreator.create(
      app_id:  @customer_app.id,
      name: "my_collection",
      components: [
        {
          name: "some name1",
          element: {type: "Title", size: 1, text: "Auto Created Component"}
        },
        {
          name: "some name2",
          element: {type: "Title", size: 2, text: "Auto Created Component2"}
        },
        {
          name: "some name3",
          element: {type: "Title", size: 3, text: "Auto Created Component3"}
        },
      ]
    )

    @component = @collection.components.first
  end

  test "should get index" do
    get components_url, as: :json, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 3, body.count
    assert body.first["element"]["type"].present?
  end

  test "should create component" do
    assert_difference('Component.count') do
      post components_url, params: {
        component: {
          name: "some name4",
          element: {type: "Title", size: 3, text: "Auto Created Component3"}
        }
      }, as: :json, headers: auth_header.merge(@app_header)
    end

    assert_response 201
  end

  test "should show component" do
    get component_url(@component), as: :json, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert body["element"].present?
  end

  test "should update component" do
    patch component_url(@component), params: { component: {
        name: "some name5",
        element: {type: "Title", size: 100, text: "More Text"}
      }
    }, as: :json, headers: auth_header.merge(@app_header)

    body = JSON.parse(response.body)

    assert_response 200
    assert_equal "some name5", body["name"]
    assert_equal 100, body["element"]["size"]

  end

  test "should destroy component" do
    assert_difference('Component.count', -1) do
      delete component_url(@component), as: :json, headers: auth_header.merge(@app_header)
    end

    assert_response 204
  end
end
