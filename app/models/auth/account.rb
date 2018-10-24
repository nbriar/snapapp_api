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

class Auth::Account < ApplicationRecord
  has_many :users, foreign_key: "auth_account_id", class_name: "Auth::User"

  def add_user(external_id:)
    Auth::User.create(external_id: external_id, account: self)
  end
end
