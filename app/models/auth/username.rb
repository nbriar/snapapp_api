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

class Auth::Username < ApplicationRecord
  has_one :user, foreign_key: "auth_account_id", class_name: "Auth::User"
  validates_presence_of :name, :password
  before_save :encrypt_password

  def validates?(entered_password)
    pass = SCrypt::Password.new(self.password)
    pass == entered_password
  end

  private
  def encrypt_password
    self.password = SCrypt::Password.create(self.password)
  end
end
