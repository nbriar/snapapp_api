# == Schema Information
#
# Table name: paragraphs
#
#  id         :bigint(8)        not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ParagraphTest < ActiveSupport::TestCase
  test "must have text" do
    paragraph = Paragraph.create()
    assert_equal ["can't be blank"], paragraph.errors.messages[:text]
  end

  test "can create paragraph" do
    paragraph = Paragraph.create(text: "sometext")

    assert paragraph.id.present?
    assert_equal "sometext", paragraph.text
  end
end
