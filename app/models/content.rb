# == Schema Information
#
# Table name: contents
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  version    :float
#

class Content < ApplicationRecord
  acts_as_taggable

end
