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

class Page < ApplicationRecord
  belongs_to :customer_app
  has_and_belongs_to_many :components
  has_and_belongs_to_many :collections

  validates_presence_of :title, :route
  validates_uniqueness_of :title, scope: :customer_app_id
  validates_uniqueness_of :route, scope: :customer_app_id

  before_validation :generate_route

  def self.for_app(app)
    Page.where(customer_app_id: app.id)
  end

  def attach_component(component)
    self.components << component
  end

  def remove_component(component)
    self.components.delete(component)
  end

  def attach_collection(collection)
    self.collections << collection
  end

  def remove_collection(collection)
    self.collections.delete(collection)
  end

  def generate_route
    self.route ||= title.downcase.gsub(" ", "-")
  end
end
