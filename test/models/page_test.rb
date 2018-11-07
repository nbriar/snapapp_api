# == Schema Information
#
# Table name: pages
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  route           :string
#  customer_app_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pages_on_customer_app_id  (customer_app_id)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  setup do
    @user = UserCreator.find_or_create(external_id: external_user_id)
    @account = @user.account
    @customer_app = CustomerApp.create(name: "testapp", auth_account_id: @account.id)
  end

  test "creating a page generates a route" do
    page = Page.create(title: 'some new title', customer_app_id: @customer_app.id)

    assert page.route == 'some-new-title'
  end
end
