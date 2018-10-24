class AddDefaultTemplate < ActiveRecord::Migration[5.1]
  def change
    template = Template.create(name: "Article")
    template.add_element(type: "Title", ordinal: 0)
    template.add_element(type: "SubTitle", ordinal: 1)
    template.add_element(type: "Paragraph", ordinal: 2)
  end
end
