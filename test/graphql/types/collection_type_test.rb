# == Schema Information
#
# Table name: collections
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :string

require 'test_helper'

class Types::CollectionTypeTest < ActiveSupport::TestCase
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
  end

  test "collection is something" do
    query = "
    {
      collection(id: #{@collection.id}) {
        name
        appId
        createdAt
        updatedAt
      }
    }"
    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["collection"]["name"] == @collection.name
    assert results["data"]["collection"]["appId"] == @collection.app_id.to_i
  end
end
