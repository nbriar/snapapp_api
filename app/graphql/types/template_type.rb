module Types
  class TemplateType < Types::BaseObject
    graphql_name "Template"

    field :name, String, null: true
    field :elements, [Types::ElementType], null: true

  end
end
