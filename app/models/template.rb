# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_name  (name) UNIQUE
#

class Template < ApplicationRecord
  has_many :template_elements
  validates :name, uniqueness: true

  def self.available_elements
    Element.available_elements
  end

  def elements
    template_elements.sort_by(&:ordinal).map do |el|
      t = el.element_type.constantize.new

      el_hash = t.as_json
      ["id", "created_at", "updated_at"].each do |key|
        el_hash.delete(key)
      end

      el_hash.merge({type: t.class.to_s})
    end
  end

  def add_element(type:, ordinal: 0)
    validate_type(type)
    return false if errors.present?
    template_elements << TemplateElement.create(element_type: type, ordinal: ordinal)
  end

  private

  def validate_type(type)
    unless Element.available_elements.include? type
      errors.add(:elements, :is_invalid, message: "Element type '#{type}' is invalid. Must be one of: #{Element.available_elements}")
    end
  end
end
