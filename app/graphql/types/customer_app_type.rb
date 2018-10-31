module Types
  class CustomerAppType < Types::BaseObject
    graphql_name "CustomerApp"

    field :id, Integer, null: false
    field :name, String, null: false
    field :slug, String, null: false
    field :pages, [Types::PageType], null: false
    field :collections, [Types::CollectionType], null: false
    field :auth_account_id, Integer, null: false
    field :updated_at, String, null: true
    field :created_at, String, null: true
  end
end
