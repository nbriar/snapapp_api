# == Schema Information
#
# Table name: template_elements
#
#  id           :bigint(8)        not null, primary key
#  element_type :string
#  ordinal      :integer
#  template_id  :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_template_elements_on_template_id  (template_id)
#

require 'test_helper'

class TemplateElementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
