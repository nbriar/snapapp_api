require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'Primary', auth_account_id: @account.id)
  end

  test "should find a customer app by ID" do
    c_app = customer_apps(:one)

    query_string = "
    {
      customerApp(id: #{c_app.id}) {
        name
        slug
        authAccountId
        createdAt
        updatedAt
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    body = JSON.parse(response.body)
    assert body["data"]["customerApp"]["name"].present?
  end

  test "should return an index of customer apps" do
    c_app = customer_apps(:one)

    query_string = "
    {
      customerApps {
        name
        slug
        authAccountId
        createdAt
        updatedAt
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    body = JSON.parse(response.body)

    assert body["data"]["customerApps"].first["name"].present?
  end

  test "should create a new customer app" do

    query_string = "
    mutation {
      createCustomerApp(input:{name: \"stuff\"}) {
        customerApp {name, slug, authAccountId}
        errors
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    body = JSON.parse(response.body)

    assert body["data"]["createCustomerApp"]["customerApp"].present?
    assert body["data"]["createCustomerApp"]["errors"].empty?
  end

  test "should delete a customer app" do
    deleteable_customer_app = CustomerApp.create(name: 'deleteable', auth_account_id: @account.id)
    query_string = "
    mutation {
      deleteCustomerApp(input:{id: #{deleteable_customer_app.id}}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    body = JSON.parse(response.body)

    assert body["data"]["deleteCustomerApp"]["customerApp"].present?
    assert body["data"]["deleteCustomerApp"]["errors"].empty?
  end

  test "should update a customer app" do
    customer_app = CustomerApp.create(name: 'updateable', auth_account_id: @account.id)
    query_string = "
    mutation {
      updateCustomerApp(input:{id: #{customer_app.id}, name: \"new-name\"}) {
        customerApp {id, name, slug, authAccountId}
        errors
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    body = JSON.parse(response.body)

    assert body["data"]["updateCustomerApp"]["customerApp"]["name"] == "new-name"
    assert body["data"]["updateCustomerApp"]["errors"].empty?
  end
end
