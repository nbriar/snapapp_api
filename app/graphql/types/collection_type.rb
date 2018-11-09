module Types
  class CollectionType < Types::BaseObject
    graphql_name "Collection"

    field :id, Integer, null: false
    field :app_id, Integer, null: false
    field :name, String, null: false
    field :components, [Types::ComponentType], null: false
    field :updated_at, String, null: true
    field :created_at, String, null: true
  end
end
