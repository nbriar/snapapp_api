require 'test_helper'

class Mutations::UpdateCollectionTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
    @collection = ::CollectionCreator.create(
      app_id: @customer_app.id,
      name: "test_collection",
      components: []
    )
  end

  test "updating a collection name works" do
    query = "
    mutation ($id: Int!, $name: String!){
      updateCollection(input:{id: $id, name: $name}) {
        collection { name }
        errors
      }
    }
    "
    variables = {id: @collection.id, name: "Updated"}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert_equal variables[:name], results["data"]["updateCollection"]["collection"]["name"]
    assert_empty results["data"]["updateCollection"]["errors"]
  end

  test "trying to update a non existent collection fails" do
    query = "
    mutation ($id: Int!, $name: String!){
      updateCollection(input:{id: $id, name: $name}) {
        collection { name }
        errors
      }
    }
    "
    variables = {id: 0, name: "Updated"}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert_includes results["data"]["updateCollection"]["errors"], "No Collection found with ID: 0"
  end
end
