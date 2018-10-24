# == Schema Information
#
# Table name: spacers
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Spacer < ApplicationRecord
  def self.field_definitions
    {type: self.new.class.to_s}
  end
end
