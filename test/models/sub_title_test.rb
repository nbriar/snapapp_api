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

require 'test_helper'

class SubTitleTest < ActiveSupport::TestCase
  test "requires text" do
    title = SubTitle.create()
    assert title.errors.messages[:text].include? "can't be blank"
  end
end
