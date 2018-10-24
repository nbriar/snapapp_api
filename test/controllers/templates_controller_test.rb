require 'test_helper'

class TemplatesControllerTest < ActionDispatch::IntegrationTest

  test "should index all the available templates" do
    t1 = templates(:one)
    t1.add_element(type: "Title")
    get templates_url, headers: auth_header

    assert_response :success

    body = JSON.parse(response.body)
    template = body["templates"].first
    assert ["templates"].is_a? Array
    assert_equal template["elements"].count, 1
    assert_equal template["elements"].first["type"], "Title"
    assert body["available_elements"].is_a? Array
  end

  test "should get a template by id" do
    t = templates(:one)
    get template_url(id: t.id), headers: auth_header

    body = JSON.parse(response.body)

    assert_response :success
    assert_equal t.id, body["template"]["id"]
    assert body["available_elements"].is_a? Array
  end

  test "should return a 404 if the template cannot be found" do
    get template_url(id: "nullid"), headers: auth_header

    assert_response :not_found
  end

  test "should create a new template" do
    post templates_url, params: {template: {name: "NewTemplate" }}, headers: auth_header
    assert_response :success
  end

  test "should update all items of an existing template" do
    t = templates(:one)
    put template_url(id: t.id), params: {
      template: {
        name: "UpdatedTemplate",
        elements: [{type: "Title"},{type: "SubTitle"},{type: "Title"},{type: "Title"}]
    }}, headers: auth_header
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal "UpdatedTemplate", body["template"]["name"]
    assert_equal 4, body["template"]["elements"].count
  end

  test "should update only the name of an existing template" do
    t = templates(:one)
    put template_url(id: t.id), params: {template: {name: "UpdatedTemplate"}}, headers: auth_header
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal "UpdatedTemplate", body["template"]["name"]
    assert_equal t.elements.count, body["template"]["elements"].count
  end

  test "should update only the elements of an existing template" do
    t = templates(:one)
    put template_url(id: t.id), params: {template: {elements: [{type: "Title"},{type: "Title"},{type: "Title"}]}}, headers: auth_header
    body = JSON.parse(response.body)

    assert_response :success
    assert_equal 3, body["template"]["elements"].count
  end

  test "should destroy a template" do
    t = Template.create(name: "Temp Template")
    delete template_url(id: t.id), headers: auth_header
    assert_response :success
  end

end
