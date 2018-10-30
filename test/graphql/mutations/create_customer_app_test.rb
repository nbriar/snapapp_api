require 'test_helper'

class Mutations::CreateCustomerAppTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
  end

  test "creating a customer app works" do
    query = "
    mutation {
      createCustomerApp(input:{name: \"new-app\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query, context: {account: @account}).to_h

    assert results["data"]["createCustomerApp"]["customerApp"]["name"] == "new-app"
    assert results["data"]["createCustomerApp"]["errors"].blank?
  end

  test "trying to create a customer app without a name fails" do
    query = "
    mutation {
      createCustomerApp(input:{name: \"\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query, context: {account: @account}).to_h

    assert results["data"]["createCustomerApp"]["errors"].include?("Name can't be blank")
  end

  test "trying to create a customer app without an account fails" do
    query = "
    mutation {
      createCustomerApp(input:{name: \"new-app\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["createCustomerApp"]["errors"].include?("Account must exist")
  end
end
