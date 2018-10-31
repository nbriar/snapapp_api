module Types
  class PageType < Types::BaseObject
    graphql_name "Page"

    field :id, Integer, null: false
    field :title, String, null: false
    field :route, String, null: false
    field :customer_app, CustomerAppType, null: false
    field :collections, [CollectionType], null: true
    field :updated_at, String, null: true
    field :created_at, String, null: false
  end
end
