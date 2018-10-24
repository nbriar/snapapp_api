require 'test_helper'

class ElementsControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "should get index" do
    get elements_url, headers: auth_header

    body = JSON.parse(response.body)

    assert_response :success
    assert_instance_of Array, body["elements"]
  end

  test "should show element by classname" do
    get element_url(id: "Title"), headers: auth_header

    body = JSON.parse(response.body)

    assert_response :success
    assert_instance_of Hash, body
  end

end
