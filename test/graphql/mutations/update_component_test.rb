require 'test_helper'

class Mutations::UpdateComponentTest < ActiveSupport::TestCase
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

  test "updating a component works" do
    query = "
    mutation ($id: Int!, $name: String!, $element: Element!){
      updateComponent(input:{id: $id, name: $name, element: $element}) {
        component {id, name, element}
        errors
      }
    }
    "
    element = {type: "Title", size: 3, text: "An Updated Component"}
    variables = {id: @collection.components.first.id, name: "Updated", element: element}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert results["data"]["updateComponent"]["component"]["name"] == variables[:name]
    assert results["data"]["updateComponent"]["component"]["element"]["text"] == element[:text]
    assert results["data"]["updateComponent"]["errors"].blank?
  end

  test "trying to update a component without an id fails" do
    query = "
    mutation {
      updateComponent(input:{}) {
        component {id}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["errors"].present?
  end

  test "trying to update a component without a name works" do
    query = "
    mutation ($id: Int!, $element: Element!){
      updateComponent(input:{id: $id, element: $element}) {
        component {id, name, element}
        errors
      }
    }
    "
    element = {type: "Title", size: 3, text: "An Updated Component"}
    variables = {id: @collection.components.last.id, element: element}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert results["data"]["updateComponent"]["component"]["name"] == @collection.components.last.name
    assert results["data"]["updateComponent"]["component"]["element"]["text"] == element[:text]
    assert results["data"]["updateComponent"]["errors"].blank?
  end

  test "must send either name or element to update" do
    query = "
    mutation ($id: Int!){
      updateComponent(input:{id: $id}) {
        component {id, name, element}
        errors
      }
    }
    "
    variables = {id: @collection.components.last.id}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert results["data"]["updateComponent"]["errors"].include? "Must supply either name or element for update"
  end

end
