module Types
  class QueryType < Types::BaseObject
    graphql_name "Query"
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # Indexes
    field :customer_apps, [CustomerAppType], null: true
    field :pages, [PageType], null: true
    field :collections, [CollectionType], null: true
    field :components, [ComponentType], null: true

    # Individual Objects by ID
    field :customer_app, CustomerAppType, null: true do
      description "Find a customer_app by ID"
      argument :id, ID, required: true
    end

    field :collection, CollectionType, null: true do
      description "Find a collection by ID"
      argument :id, ID, required: true
    end

    field :component, ComponentType, null: true do
      description "Find a component by ID"
      argument :id, ID, required: true
    end

    field :page, PageType, null: true do
      description "Find a page by ID"
      argument :id, ID, required: true
    end

    def customer_apps
      CustomerApp.for_account(context[:account])
    end

    def customer_app(id:)
      CustomerApp.find(id)
    end

    def collection(id:)
      Collection.find(id)
    end

    def collections
      Collection.for_app(context[:customer_app])
    end

    def component(id:)
      Component.find(id)
    end

    def components
      Component.for_app(context[:customer_app])
    end

    def page(id:)
      Page.find(id)
    end

    def pages
      Page.for_app(context[:customer_app])
    end
  end
end
