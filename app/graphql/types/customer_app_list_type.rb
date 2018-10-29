module Types
  class CustomerAppListType < Types::BaseObject
    graphql_name "CustomerAppList"
    field :customer_apps, [Types::CustomerAppType], null: true
  end
end
