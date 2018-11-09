module Types
  class MutationType < Types::BaseObject
    graphql_name "Mutation"
    field :create_customer_app, mutation: Mutations::CreateCustomerApp
    field :update_customer_app, mutation: Mutations::UpdateCustomerApp
    field :delete_customer_app, mutation: Mutations::DeleteCustomerApp

    field :create_page, mutation: Mutations::CreatePage
    field :update_page, mutation: Mutations::UpdatePage
    field :delete_page, mutation: Mutations::DeletePage

    field :create_collection, mutation: Mutations::CreateCollection
    # field :update_component, mutation: Mutations::UpdateComponent
    # field :delete_component, mutation: Mutations::DeleteComponent

    field :create_component, mutation: Mutations::CreateComponent
    field :update_component, mutation: Mutations::UpdateComponent
    field :delete_component, mutation: Mutations::DeleteComponent
  end
end
