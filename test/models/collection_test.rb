# == Schema Information
#
# Table name: collections
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :string
#
# Indexes
#
#  index_collections_on_app_id_and_name  (app_id,name) UNIQUE
#

require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
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
        }
      ]
    )
  end

  test "for_app returns only components for that app" do
    collections = Collection.for_app(@customer_app)

    assert_equal 1, collections.count
    assert_equal 3, collections.first.components.count
  end
end
