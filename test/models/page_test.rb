# == Schema Information
#
# Table name: pages
#
#  id              :bigint(8)        not null, primary key
#  title           :string
#  route           :string
#  customer_app_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pages_on_customer_app_id  (customer_app_id)
#

require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
