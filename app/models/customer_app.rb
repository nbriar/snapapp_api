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

class CustomerApp < ApplicationRecord
  belongs_to :account, foreign_key: "auth_account_id", class_name: "Auth::Account"

  validates_presence_of :auth_account_id
  validates_presence_of :name

  validates_uniqueness_of :name, scope: :auth_account_id

  after_initialize :ensure_slug

  def self.for_account(acc)
    CustomerApp.where(auth_account_id: acc.id)
  end

  def pages
    Page.for_app(self)
  end

  def collections
    Collection.for_app(self)
  end

  def components
    Component.for_app(self)
  end

  private
  def ensure_slug
    self.slug ||= generate_slug
  end

  def generate_slug
    Faker::Config.random.seed
    slug_pieces.join('-').downcase.gsub(' ', '-')
  end

  def slug_pieces
    [
      Faker::Ancient.god,
      Faker::App.name,
      Faker::Cat.name,
      Faker::Lorem.characters(8)
    ]
  end
end
