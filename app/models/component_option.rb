# == Schema Information
#
# Table name: component_options
#
#  id                 :bigint(8)        not null, primary key
#  xs_width           :integer
#  conditional_render :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ComponentOption < ApplicationRecord
end
