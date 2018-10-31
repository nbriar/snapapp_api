# == Schema Information
#
# Table name: components
#
#  id            :bigint(8)        not null, primary key
#  app_id        :string
#  collection_id :integer
#  element_id    :integer
#  element_type  :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_components_on_app_id_and_name  (app_id,name) UNIQUE
#  index_components_on_collection_id    (collection_id)
#

class Component < ApplicationRecord
  has_and_belongs_to_many :pages

  validates_uniqueness_of :name, scope: :app_id

  def self.for_app(app)
    Component.where(app_id: app.id)
  end

  def self.for_page(page_id)
    Page.find(page_id).components
  end

  def element
    active_record_element.as_json.merge(type: active_record_element.class.to_s)
  end

  def template
    element[:type].constantize.field_definitions
  end

  def active_record_element
    @el ||= element_type.constantize.find element_id
  end
end
