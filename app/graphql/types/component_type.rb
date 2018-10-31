module Types
  class ComponentType < Types::BaseObject
    graphql_name "Component"

    field :id, Integer, null: false
    field :app_id, Integer, null: false
    field :collection_id, Integer, null: false
    field :name, String, null: false
    field :element, Types::ElementType, null: false
    field :template, Types::ElementTemplateType, null: false
    field :updated_at, String, null: true
    field :created_at, String, null: true
  end
end
