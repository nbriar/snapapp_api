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

class Auth::User < ApplicationRecord
  belongs_to :account, foreign_key: "auth_account_id", class_name: "Auth::Account"
  after_initialize :validate_account

  # Authorization Methods
  has_one :username, foreign_key: "auth_user_id", class_name: "Auth::Username"

  private

  def validate_account
    self.account ||= Auth::Account.create(name: self.external_id) if self.new_record?
  end
end
