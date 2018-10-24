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

require 'test_helper'

class TitleTest < ActiveSupport::TestCase
  test "requires text" do
    title = Title.create()
    assert title.errors.messages[:text].include? "can't be blank"
  end
end
