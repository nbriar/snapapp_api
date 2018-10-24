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

require 'test_helper'

class HyperlinkTest < ActiveSupport::TestCase
  test "requires a url to be created" do
    link = Hyperlink.create()
    assert_equal ["can't be blank"], link.errors.messages[:url]
  end

  test "url must start with / or http:// or https://" do
    link = Hyperlink.create(url: "invalid_url")
    assert link.errors.messages[:url].include? "must be a valid link starting with `/`, `http://` or `https://`"
  end

  test "url must not have spaces" do
    link = Hyperlink.create(url: "/invalid url")
    assert link.errors.messages[:url].include? "must not have spaces"
  end

  test "can create a hyperlink" do
    link = Hyperlink.create(url: "/valid_url")
    assert link.id.present?
  end
end
