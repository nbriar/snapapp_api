# == Schema Information
#
# Table name: paragraphs
#
#  id         :bigint(8)        not null, primary key
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Paragraph < ApplicationRecord
  include ComponentOptionsModule

  validates_presence_of :text

  def self.field_definitions
    {
      text: {
        data_type: :string,
        display: true,
        required: true,
        field_type: :textarea,
        default_value: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dapibus lorem turpis, in posuere neque porttitor quis. Donec ut felis risus. Nam fermentum non tortor at semper. Morbi gravida pulvinar felis, lobortis elementum tellus luctus vel. Sed vel lorem at nibh lacinia interdum blandit ac orci. Nunc imperdiet velit sit amet maximus faucibus. Nunc ut elit dignissim, auctor dui et, cursus tellus. Phasellus ac urna a lorem venenatis varius. Curabitur faucibus dui porta odio ultrices pellentesque quis nec massa. Duis aliquet augue in dapibus rhoncus. Morbi ac neque rutrum, dictum justo non, condimentum dolor. Duis vitae luctus elit. Etiam at euismod nisi. Sed venenatis eu nisi et feugiat."
      },
      blockquote: {data_type: :boolean, field_type: :boolean, label: "Block Quote", default_value: false},
      type: self.new.class.to_s
    }
  end
end
