# == Schema Information
#
# Table name: collections
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :string
#
# Indexes
#
#  index_collections_on_app_id_and_name  (app_id,name) UNIQUE
#

class Collection < ApplicationRecord
  has_many :components
  has_and_belongs_to_many :pages

  validates_uniqueness_of :name, scope: :app_id

  def self.for_app(app)
    Collection.where(app_id: app.id)
  end

  def self.for_page(page)
    Page.collections
  end
end
