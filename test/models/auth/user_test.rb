# == Schema Information
#
# Table name: auth_users
#
#  id               :bigint(8)        not null, primary key
#  email            :string
#  auth_account_id  :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  auth_username_id :integer
#  external_id      :string
#
# Indexes
#
#  index_auth_users_on_auth_account_id  (auth_account_id)
#  index_auth_users_on_email            (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (auth_account_id => auth_accounts.id)
#

require 'test_helper'

class Auth::UserTest < ActiveSupport::TestCase
  test "a user with out an account will have an account created automatically" do
    user = Auth::User.create(email: "test@test.com")

    assert user.account.present?
  end

  test "a user with an account will not change accounts" do
    user = Auth::User.create(email: "test@test.com")
    account = user.account
    user.update(email: "updated@test.com")
    user.reload

    assert_equal account, user.account
  end
end
