module Types
  class MutationType < Types::BaseObject
    graphql_name "Mutation"
    field :create_customer_app, mutation: Mutations::CreateCustomerApp
    field :delete_customer_app, mutation: Mutations::DeleteCustomerApp
    field :update_customer_app, mutation: Mutations::UpdateCustomerApp

  end
end
