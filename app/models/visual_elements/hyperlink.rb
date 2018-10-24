# == Schema Information
#
# Table name: hyperlinks
#
#  id         :bigint(8)        not null, primary key
#  url        :string
#  text       :string
#  target     :string
#  action     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hyperlink < ApplicationRecord
  validates_presence_of :url
  validate :valid_url
  validate :url_has_no_spaces

  def self.field_definitions
    {
      text: {data_type: :string, field_type: :text, display: true, required: true, default_value: "New Link"},
      url: {data_type: :string, field_type: :text, validation: 'url', required: true},
      target: {data_type: :string, field_type: :select, options: [
        {label: "Current Window/Tab (default)", value: "_self"},
        {label: "New Window/Tab", value: "_blank"}
      ]},
      action: {data_type: :string, field_type: :text},
      type: self.new.class.to_s
    }
  end

  private
  def valid_url
    return if !url || url.starts_with?("/") || url.starts_with?("http://") || url.starts_with?("https://")

    errors.add(:url, "must be a valid link starting with `/`, `http://` or `https://`")
  end

  def url_has_no_spaces
    return if !url || !url.index(/\s/)

    errors.add(:url, "must not have spaces")
  end
end
