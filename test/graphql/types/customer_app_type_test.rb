require 'test_helper'

class Types::CustomerAppTypeTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'collection app', auth_account_id: @account.id)

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

    @page = Page.create(title: "First Page", route: "/home", customer_app: @customer_app)
  end

  test "getting the index for relevant account only" do
    query = "
    {
      customerApps () {
        name
      }
    }"
    # Create another account and app to make sure we only return the relevant apps
    temp_user = UserCreator.find_or_create(external_id: 'somenastyid')
    a = CustomerApp.create(name: 'collection app', auth_account_id: temp_user.account.id)

    results = SnapAppApiSchema.execute(query, context: {account: @account}).to_h

    assert results["data"]["customerApps"].count == 1
    assert results["data"]["customerApps"].first["name"] == @customer_app.name
  end

  test "getting a customer_app by ID" do
    query = "
    {
      customerApp (id: #{@customer_app.id}) {
        name
      }
    }"

    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["customerApp"]["name"] == @customer_app.name
  end

  test "getting pages for a customer_app" do
    query = "
    {
      customerApp (id: #{@customer_app.id}) {
        name
        pages {
          title
        }
      }
    }"

    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["customerApp"]["pages"].count == 1
  end

  test "getting collections for a customer_app" do
    query = "
    {
      customerApp (id: #{@customer_app.id}) {
        name
        collections {
          name
          components {
            name
          }
        }
      }
    }"

    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["customerApp"]["collections"].first["components"].count == 3
  end
end
