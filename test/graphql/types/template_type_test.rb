require 'test_helper'

class Types::TemplateTypeTest < ActiveSupport::TestCase
  setup do
    @t = Template.create({name: 'first'})
    @t.add_element(type: "Title", ordinal: 0)
  end

  test "getting the index for templates" do
    query = "
    {
      elementTypes
    }"
    results = SnapAppApiSchema.execute(query, context: {account: @account}).to_h

    assert_includes results["data"]["elementTypes"], "Title"
  end

  test "elements are available in the query" do
    query = "
    {
        template (id: #{@t.id}) {
          name
          elements
        }
    }"

    results = SnapAppApiSchema.execute(query).to_h

    assert_equal "Title", results["data"]["template"]["elements"].first[:type]
  end
  #
  # test "getting pages for a customer_app" do
  #   query = "
  #   {
  #     customerApp (id: #{@customer_app.id}) {
  #       name
  #       pages {
  #         title
  #       }
  #     }
  #   }"
  #
  #   results = SnapAppApiSchema.execute(query).to_h
  #
  #   assert results["data"]["customerApp"]["pages"].count == 1
  # end
  #
  # test "getting collections for a customer_app" do
  #   query = "
  #   {
  #     customerApp (id: #{@customer_app.id}) {
  #       name
  #       collections {
  #         name
  #         components {
  #           name
  #         }
  #       }
  #     }
  #   }"
  #
  #   results = SnapAppApiSchema.execute(query).to_h
  #
  #   assert results["data"]["customerApp"]["collections"].first["components"].count == 3
  # end
end
