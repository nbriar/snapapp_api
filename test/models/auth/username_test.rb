# == Schema Information
#
# Table name: auth_usernames
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  password     :string
#  auth_user_id :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_auth_usernames_on_auth_user_id  (auth_user_id)
#  index_auth_usernames_on_name          (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (auth_user_id => auth_users.id)
#

require 'test_helper'

class Auth::UsernameTest < ActiveSupport::TestCase
  setup do
    @user = Auth::User.create(email: "test@test.com")
    @creds = Auth::Username.create(name: "admin", password: "password", user: @user)
  end

  test ".validates? returns true for a correct password" do
    assert @creds.validates?("password")
  end

  test ".validates? returns false for an incorrect password" do
    refute @creds.validates?("incorrect")
  end
end
