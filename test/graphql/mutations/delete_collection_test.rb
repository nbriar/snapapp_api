require 'test_helper'

class Mutations::DeleteCollectionTest < ActiveSupport::TestCase
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

  test "deleting a collection works" do
    query = "
    mutation ($id: Int!){
      deleteCollection(input:{id: $id}) {
        collection { id }
        errors
      }
    }
    "
    variables = {id: @collection.id}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert_equal variables[:id], results["data"]["deleteCollection"]["collection"]["id"]
    assert_empty results["data"]["deleteCollection"]["errors"]
  end

  test "trying to delete a non existent collection fails" do
    query = "
    mutation ($id: Int!){
      deleteCollection(input:{id: $id}) {
        collection { id }
        errors
      }
    }
    "
    variables = {id: 0}
    results = SnapAppApiSchema.execute(query, variables: variables).to_h

    assert_includes results["data"]["deleteCollection"]["errors"], "No Collection found with ID: 0"
  end
end
