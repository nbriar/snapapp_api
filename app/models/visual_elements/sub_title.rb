# == Schema Information
#
# Table name: sub_titles
#
#  id             :bigint(8)        not null, primary key
#  text           :string
#  size           :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  bottom_divider :boolean
#  top_divider    :boolean
#  inset          :boolean
#

class SubTitle < ApplicationRecord
  validates_presence_of :text

  def self.field_definitions
    {
      text: {data_type: :string, field_type: :text, default_value: "New SubTitle", required: true, display: true},
      size: {data_type: :integer, field_type: :select, default_value: 0, options: [
        {label: "Default", value: 0},
        {label: "SubTitle1", component: "heading", value: 1},
        {label: "SubTitle2", component: "heading", value: 2},
        {label: "SubTitle3", component: "heading", value: 3},
        {label: "SubTitle4", component: "heading", value: 4}
      ]},
      top_divider: {data_type: :boolean, field_type: :boolean, label: "Top Divider"},
      bottom_divider: {data_type: :boolean, field_type: :boolean, label: "Bottom Divider"},
      inset: {data_type: :boolean, field_type: :boolean},
      type: self.new.class.to_s
    }
  end
end
