# == Schema Information
#
# Table name: tags
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  taggings_count :integer          default(0)
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#

class Tag < ApplicationRecord
end
