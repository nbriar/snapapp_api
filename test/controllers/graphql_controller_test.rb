require 'test_helper'

class GraphqlControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    content = contents(:one)
    content.tag_list.add('testing')
    content.save

    query_string = "
    {
      content(id: #{content.id}) {
        name
        text
        tags { name }
      }
    }"

    post graphql_url, params: {query: query_string}, headers: auth_header
    assert_response :success
    body = JSON.parse(response.body)

    assert body["data"].present?
    assert body["data"]["content"]["tags"].count > 0
  end
end
