# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_name  (name) UNIQUE
#

require 'test_helper'

class TemplateTest < ActiveSupport::TestCase
  test "we can create a template" do
    t = Template.create(name: "A Template")
    assert t.id.present?
  end

  test "templates must have a unique name" do
    t1 = Template.create(name: "A Template")
    t2 = Template.create(name: "A Template")

    assert t2.errors.present?
  end

  test "can add elements to a template" do
    t1 = templates(:one)
    t1.add_element(type: "Title")

    assert_equal 1, t1.elements.count
  end

  test "instantiates new elements on the template when elements are valid" do
    t1 = templates(:one)
    t1.add_element(type: "Title")

    assert_equal "Title", t1.elements.first[:type]
  end

  test "throws errors on the template when elements are invalid" do
    t1 = templates(:one)
    t1.add_element(type: "Title")

    assert_equal "Title", t1.elements.first[:type]
  end

  test "should have the elements ordered by ordinal" do
    t1 = templates(:one)
    t1.add_element(type: "SubTitle", ordinal: 3)
    t1.add_element(type: "Title", ordinal: 0)
    t1.add_element(type: "Title", ordinal: 1)

    assert_equal "SubTitle", t1.elements.last[:type]
  end
end
