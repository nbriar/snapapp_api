module Types
  class QueryType < Types::BaseObject
    graphql_name "Query"
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :customer_app, CustomerAppType, null: true do
      description "Find a customer_app by ID"
      argument :id, ID, required: true
    end

    def customer_app(id:)
      CustomerApp.find(id)
    end
  end
end
