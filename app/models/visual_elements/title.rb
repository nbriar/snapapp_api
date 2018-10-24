# == Schema Information
#
# Table name: titles
#
#  id         :bigint(8)        not null, primary key
#  text       :string
#  size       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Title < ApplicationRecord
  validates_presence_of :text

  # :label and : value are required for options items
  def self.field_definitions
    {
      text: {data_type: :string, field_type: :text, default_value: "New Title", required: true, display: true},
      size: {data_type: :integer, field_type: :select, default_value: 1, options: [
        {label: "Heading1", component: "heading", value: 1},
        {label: "Heading2", component: "heading", value: 2},
        {label: "Heading3", component: "heading", value: 3},
        {label: "Heading4", component: "heading", value: 4},
        {label: "Heading5", component: "heading", value: 5}
      ]},
      type: self.new.class.to_s
    }
  end
end
