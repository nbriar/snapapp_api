require 'test_helper'

class Mutations::CreateCollectionTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'component app', auth_account_id: @account.id)
  end

  test "creating a component works" do
    query = "
    mutation ($name: String!, $appId: Int!, $components: [ComponentInput!]!) {
      createCollection(input:{name: $name, appId: $appId, components: $components}) {
        collection {id, name, components {
          name
          element
          }}
        errors
      }
    }
    "
    components = [
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
      }
    ]
    variables = {name: "New Collection", appId: @customer_app.id, components: components}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    refute_nil results["data"]["createCollection"]["collection"]["id"]
    assert_equal 3, results["data"]["createCollection"]["collection"]["components"].count
    refute_nil results["data"]["createCollection"]["collection"]["components"].first["element"]["id"]
  end

  test "creating a collection without components succeeds" do
    query = "
    mutation ($name: String!, $appId: Int!, $components: [ComponentInput!]!) {
      createCollection(input:{name: $name, appId: $appId, components: $components}) {
        collection {id, name, components { name }}
        errors
      }
    }
    "
    variables = {appId: @customer_app.id, name: 'test', components: []}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    assert_empty results["data"]["createCollection"]["errors"]
  end

  test "trying to create a collection without a name fails" do
    query = "
    mutation ($appId: Int!, $components: [ComponentInput!]!) {
      createCollection(input:{appId: $appId, components: $components}) {
        collection {id, name}
        errors
      }
    }
    "

    variables = {name: 'test', appId: @customer_app.id, components: []}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    refute_empty results["errors"]
  end

end
