# == Schema Information
#
# Table name: auth_accounts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_auth_accounts_on_name  (name) UNIQUE
#

require 'test_helper'

class Auth::AccountTest < ActiveSupport::TestCase
  test "many users can be attached to an account" do
    account = Auth::Account.create(name: "TEST")
    account.add_user(external_id: "first@email.com")
    account.add_user(external_id: "second@email.com")
    account.add_user(external_id: "third@email.com")

    assert_equal 3, account.users.count
  end
end
