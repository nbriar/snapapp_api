# == Schema Information
#
# Table name: customer_apps
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  slug            :string
#  auth_account_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_customer_apps_on_auth_account_id  (auth_account_id)
#

require 'test_helper'

class CustomerAppTest < ActiveSupport::TestCase
  test "an app will always have a slug" do
    app = CustomerApp.create(name: "testapp")
    assert app.slug.present?
  end
end
