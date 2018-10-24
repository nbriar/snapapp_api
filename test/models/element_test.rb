require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  test ".available_elements returns an array" do
    assert_instance_of Array, Element.available_elements
  end

  test ".find returns false if title is not a valid element name" do
    refute Element.find("NoElement")
  end

  test ".find returns a hash for a valid element name" do
    assert_instance_of Hash, Element.find(Element.available_elements.first)
  end

  test ".all returns an array of hashes for all valid elements" do
    elements = Element.all
    titles = elements.map{ |el| el[:type] }
    assert_equal Element.available_elements, titles
  end
end
