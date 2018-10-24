# == Schema Information
#
# Table name: components
#
#  id            :bigint(8)        not null, primary key
#  app_id        :string
#  collection_id :integer
#  element_id    :integer
#  element_type  :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_components_on_app_id_and_name  (app_id,name) UNIQUE
#  index_components_on_collection_id    (collection_id)
#

require 'test_helper'

class ComponentTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: 'component app', auth_account_id: @account.id)

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

  test "for_app returns only components for that app" do
    components = Component.for_app(@customer_app)
    assert_equal 3, components.count
  end

  test "active_record_element returns the active record model for the element of the component" do
    component = @collection.components.first
    assert_equal Title, component.active_record_element.class
  end

  test "element returns the hash with type for the element of the component" do
    component = @collection.components.first
    assert_equal "Title", component.element[:type]
  end
end
