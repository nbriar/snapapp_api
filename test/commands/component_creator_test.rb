require 'test_helper'

class ComponentCreatorTest < ActiveSupport::TestCase
  test "can create a single component" do
    component = ::ComponentCreator.create(
      app_id: "test",
      name: "some name",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    assert component.id.present?
    assert component.element["id"].present?
  end

  test "can update a single component with name and element" do
    original = ::ComponentCreator.create(
      app_id: "test",
      name: "some name",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    component = ::ComponentCreator.update(
      id: original.id,
      name: "some updated name",
      element: {type: "Title", size: 5, text: "Updated Component"}
    )

    assert_equal "some updated name", component.name
    assert_equal 5, component.element["size"]
  end

  test "can delete component and element" do
    original = ::ComponentCreator.create(
      app_id: "test",
      name: "some name",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    ::ComponentCreator.delete(id: original.id)

    assert_raises ActiveRecord::RecordNotFound do
      Component.find original.id
    end
    assert_raises ActiveRecord::RecordNotFound do
      original.active_record_element
    end
  end

  test "can add and remove a component on a page" do
    component = ::ComponentCreator.create(
      app_id: "test",
      name: "some name",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )
    customer_app = CustomerApp.create(name: "test", auth_account_id: "nullaccount")
    page = Page.create(title: "testme", route: "/", customer_app: customer_app)

    ComponentCreator.add_to_page(id: component.id, page_id: page.id)

    assert_equal 1, page.components.length

    ComponentCreator.remove_from_page(id: component.id, page_id: page.id)
    page.reload

    assert_equal 0, page.components.length
    assert Component.find component.id
  end

  test "can add and remove a component on a collection" do
    collection = ::CollectionCreator.create(
      app_id: "test",
      name: "my_collection",
      components: [
        {
          name: "some name1",
          element: {type: "Title", size: 1, text: "Auto Created Component"}
        }
      ]
    )

    assert_equal 1, collection.components.length

    component = ::ComponentCreator.create(
      app_id: "test",
      name: "some name",
      element: {type: "Title", size: 1, text: "Auto Created Component"}
    )

    ComponentCreator.add_to_collection(id: component.id, collection_id: collection.id)
    collection.reload

    assert_equal 2, collection.components.length

    ComponentCreator.remove_from_collection(id: component.id, collection_id: collection.id)
    collection.reload

    assert_equal 1, collection.components.length
  end
end
