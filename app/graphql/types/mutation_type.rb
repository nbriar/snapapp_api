module Types
  class MutationType < Types::BaseObject
    graphql_name "Mutation"
    field :create_customer_app, mutation: Mutations::CreateCustomerApp
    field :update_customer_app, mutation: Mutations::UpdateCustomerApp
    field :delete_customer_app, mutation: Mutations::DeleteCustomerApp

    field :create_page, mutation: Mutations::CreatePage
    field :update_page, mutation: Mutations::UpdatePage
    field :delete_page, mutation: Mutations::DeletePage

  end
end
