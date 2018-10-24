require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'collection controller app', auth_account_id: @account.id)
    @app_header = {"X-APP-ID": @customer_app.id}
    @collection1 = ::CollectionCreator.create(
      app_id: @customer_app.id,
      name: "test_collection",
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
    @collection2 = ::CollectionCreator.create(
      app_id: @customer_app.id,
      name: "test2_collection",
      components: [
        {
          name: "some name4",
          element: {type: "Title", size: 4, text: "Auto Created Component"}
        },
        {
          name: "some name5",
          element: {type: "Title", size: 5, text: "Auto Created Component2"}
        },
        {
          name: "some name6",
          element: {type: "Title", size: 6, text: "Auto Created Component3"}
        },
      ]
    )
    @collection3 = ::CollectionCreator.create(
      app_id: "not_inncluded",
      name: "test3_collection",
      components: [
        {
          name: "some not included component",
          element: {type: "Hyperlink", url: "http://trythis.com"}
        }
      ]
    )
  end

  test "indexes the collections for a specific application" do
    get collections_url, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 2, body.count
    assert_equal 3, body.first["components"].count
  end

  test "should show the requested collection" do
    get collection_url(@collection1), headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 3, body["components"].count
  end

  test "can create a collection" do
    params = { collection: {
      name: "created_collection",
      components: [
        {
          name: "collection component 1",
          element: {type: "Title", size: 1, text: "Auto Created Component"}
        },
        {
          name: "collection component 2",
          element: {type: "Title", size: 2, text: "Auto Created Component2"}
        },
        {
          name: "collection component 3",
          element: {type: "Title", size: 3, text: "Auto Created Component3"}
        },
      ]
    }}

    post collections_url, params: params, headers: auth_header.merge(@app_header)
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal "created_collection", body["name"]
    assert_equal 3, body["components"].count
  end

  test "can update the name of a collection" do
    put collection_url(@collection2), params: {collection: {name: "updatedName"}}, headers: auth_header.merge(@app_header)
    @collection2.reload

    assert_response :success
    assert_equal "updatedName", @collection2.name
  end

  test "can delete a collection" do
    delete collection_url(@collection3), headers: auth_header.merge(@app_header)

    assert_response :success
  end
end
