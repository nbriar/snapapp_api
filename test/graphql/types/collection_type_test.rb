# == Schema Information
#
# Table name: collections
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  app_id     :string
#
# Indexes
#
#  index_collections_on_app_id_and_name  (app_id,name) UNIQUE
#

require 'test_helper'

class Types::CollectionTypeTest < ActiveSupport::TestCase

  test "collection is something" do
    assert true
  end
end
