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

class Types::ComponentTypeTest < ActiveSupport::TestCase
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

    @component = @collection.components.first
  end

  test "getting a component by ID" do
    query = "
    {
      component(id: #{@component.id}) {
        name
        element
        template
      }
    }"

    results = SnapAppApiSchema.execute(query).to_h

    assert results["data"]["component"]["element"] == @component.element
    assert results["data"]["component"]["template"] == @component.template
  end
end
