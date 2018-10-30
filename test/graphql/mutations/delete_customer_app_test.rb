require 'test_helper'

class Mutations::DeleteCustomerAppTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
  end

  test "deleting a customer app works" do
    query = "
    mutation {
      deleteCustomerApp(input:{id: #{@customer_app.id}}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["deleteCustomerApp"]["customerApp"]["name"] == @customer_app.name
    assert results["data"]["deleteCustomerApp"]["errors"].blank?
  end

  test "trying to delete a customer app without an id fails" do
    query = "
    mutation {
      deleteCustomerApp(input:{}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["errors"].present?
  end

  test "trying to delete a customer app that doesn't exist fails" do
    query = "
    mutation {
      deleteCustomerApp(input:{id: 0}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["deleteCustomerApp"]["errors"].include?("No CustomerApp found with ID: 0")
  end
end
