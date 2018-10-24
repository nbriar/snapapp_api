require 'test_helper'

class CollectionCreatorTest < ActiveSupport::TestCase
  setup do
    @collection = ::CollectionCreator.create(
      app_id: "test",
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
  end

  test "can create a collection with many components" do
    assert @collection.id.present?
    assert_equal 3, @collection.components.count
  end

  test "can create a collection without any components" do
    lonely_collection = ::CollectionCreator.create(
      app_id: "test",
      name: "lonely collection",
      components: []
    )

    assert lonely_collection.id.present?
    assert_equal 0, lonely_collection.components.count
  end

  test "can create a collection with a hyperlink" do
    @collection = ::CollectionCreator.create(
      app_id: "test",
      name: "another_collection",
      components: [
        {
          name: "some name1",
          element: {type: "Hyperlink", url: "/validurl"}
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

  test "can update the name of a collection" do
    ::CollectionCreator.update(id: @collection.id, name: "newName")
    @collection.reload

    assert_equal "newName", @collection.name
  end

  test "can delete collection, all components and elements" do
    collection = ::CollectionCreator.create(
      app_id: "delete_test",
      name: "deletable_collection",
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
    collection_id = collection.id
    component_id = collection.components.first.id
    element_type = collection.components.first.element[:type]
    element_id = collection.components.first.element["id"]

    ::CollectionCreator.delete(id: collection.id)

    assert_raises ActiveRecord::RecordNotFound do
      Collection.find collection_id
    end

    assert_raises ActiveRecord::RecordNotFound do
      Component.find component_id

    end

    assert_raises ActiveRecord::RecordNotFound do
      element_type.constantize.find element_id
    end
  end

  test "can add and remove a collection on a page" do
    user = UserCreator.find_or_create(external_id: external_user_id)
    account = user.account
    customer_app = CustomerApp.create(name: 'Primary', auth_account_id: account.id)
    app_header = {"X-APP-ID": customer_app.id}

    page = Page.create(title: "TestPage", route: "/testme", customer_app: customer_app)

    CollectionCreator.add_to_page(id: @collection.id, page_id: page.id)
    page.reload

    assert_equal 1, page.collections.count

    collection = page.collections.first
    CollectionCreator.remove_from_page(id: @collection.id, page_id: page.id)
    page.reload

    assert_equal 0, page.collections.count
    assert Collection.find collection.id
  end
end
