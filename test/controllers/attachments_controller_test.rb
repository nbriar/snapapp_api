require 'test_helper'

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'collection controller app', auth_account_id: @account.id)
    @app_header = {"X-APP-ID": @customer_app.id}
    @page = Page.create(title: "TestPage", route: "/testme", customer_app: @customer_app)
    @collection = ::CollectionCreator.create(
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
  end

  test "can attach a component to a collection" do
    component = ::ComponentCreator.create(
      app_id: @customer_app.id,
      name: "my new attached component",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    post attachments_create_url, params: {collection_id: @collection.id, component_id: component.id}, headers: auth_header.merge(@app_header)

    assert_response :success
    assert_equal 4, @collection.components.count
  end

  test "can remove a component from a collection" do
    post attachments_delete_url, params: {collection_id: @collection.id, component_id: @collection.components.first.id}, headers: auth_header.merge(@app_header)
    @collection.reload

    assert_response :success
    assert_equal 2, @collection.components.count
  end

  test "can attach and remove a component from a page" do
    component = ::ComponentCreator.create(
      app_id: @customer_app.id,
      name: "my new attached component",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    post attachments_create_url, params: {page_id: @page.id, component_id: component.id}, headers: auth_header.merge(@app_header)
    @page.reload

    assert_response :success
    assert_equal 1, @page.components.count

    post attachments_delete_url, params: {page_id: @page.id, component_id: component.id}, headers: auth_header.merge(@app_header)
    @page.reload

    assert_response :success
    assert_equal 0, @page.components.count
  end

  test "can attach and remove a collection from a page" do
    post attachments_create_url, params: {page_id: @page.id, collection_id: @collection.id}, headers: auth_header.merge(@app_header)
    @page.reload

    assert_response :success
    assert_equal 1, @page.collections.count

    post attachments_delete_url, params: {page_id: @page.id, collection_id: @collection.id}, headers: auth_header.merge(@app_header)
    @page.reload

    assert_response :success
    assert_equal 0, @page.collections.count
  end
end
