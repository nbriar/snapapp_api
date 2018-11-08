require 'test_helper'

class Mutations::DeleteComponentTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
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

  test "deleting a component works" do
    component = Component.for_app(@customer_app).first

    query = "
    mutation {
      deleteComponent(input:{id: #{component.id}}) {
        component {id, name, element}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["deleteComponent"]["component"]["id"] == component.id
    assert results["data"]["deleteComponent"]["errors"].blank?
  end

  test "trying to delete a component without an id fails" do
    query = "
    mutation {
      deleteComponent(input:{}) {
        component {id}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["errors"].present?
  end

  test "trying to delete a component that doesn't exist fails" do
    query = "
    mutation {
      deleteComponent(input:{id: 0}) {
        component {id}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["deleteComponent"]["errors"].include?("No Component found with ID: 0")
  end
end
