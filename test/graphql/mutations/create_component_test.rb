require 'test_helper'

class Mutations::CreateComponentTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'component app', auth_account_id: @account.id)
  end

  test "creating a component works" do
    query = "
    mutation ($name: String!, $appId: Int!, $element: Element!) {
      createComponent(input:{name: $name, appId: $appId, element: $element}) {
        component {id, name, element}
        errors
      }
    }
    "
    element = {type: "Title", size: 1, text: "Auto Created Component"}
    variables = {name: "New component", appId: @customer_app.id, element: element}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    assert results["data"]["createComponent"]["component"]["id"].present?
    assert results["data"]["createComponent"]["component"]["element"][:type] == element[:type]
    assert results["data"]["createComponent"]["component"]["element"]["id"].present?
  end

  test "trying to create a component without a name fails" do
    query = "
    mutation ($name: String!, $appId: Int!, $element: Element!) {
      createComponent(input:{name: $name, appId: $appId, element: $element}) {
        component {id, name, element}
        errors
      }
    }
    "
    element = {type: "Title", size: 1, text: "Auto Created Component"}
    variables = {appId: @customer_app.id, element: element}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    assert results["errors"].count > 0
  end

  test "trying to create a component without an element fails" do
    query = "
    mutation ($name: String!, $appId: Int!, $element: Element!) {
      createComponent(input:{name: $name, appId: $appId, element: $element}) {
        component {id, name, element}
        errors
      }
    }
    "
    element = {type: "Title", size: 1, text: "Auto Created Component"}
    variables = {name: "New Component", appId: @customer_app.id}

    results = SnapAppApiSchema.execute(query, context: {account: @account}, variables: variables).to_h

    assert results["errors"].count > 0
  end

end
