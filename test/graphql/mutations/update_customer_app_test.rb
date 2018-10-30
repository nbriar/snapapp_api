require 'test_helper'

class Mutations::UpdateCustomerAppTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
  end

  test "deleting a customer app works" do
    query = "
    mutation {
      updateCustomerApp(input:{id: #{@customer_app.id}, name: \"Updated\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["updateCustomerApp"]["customerApp"]["name"] == "Updated"
    assert results["data"]["updateCustomerApp"]["errors"].blank?
  end

  test "trying to delete a customer app without an id fails" do
    query = "
    mutation {
      updateCustomerApp(input:{name: \"Updated\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["errors"].present?
  end

  test "trying to delete a customer app without a name fails" do
    query = "
    mutation {
      updateCustomerApp(input:{id: #{@customer_app.id}}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["errors"].present?
  end

  test "trying to update a customer app that doesn't exist fails" do
    query = "
    mutation {
      updateCustomerApp(input:{id: 0, name: \"No Update\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }
    "
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["updateCustomerApp"]["errors"].include?("No CustomerApp found with ID: 0")
  end
end
