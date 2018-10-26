module Mutations
  class CreateCustomerApp < Mutations::BaseMutation
    null true

    argument :name, String, required: true

    field :customer_app, Types::CustomerAppType, null: true
    field :errors, [String], null: false

    def resolve(name:)
      customer_app = CustomerApp.new(name: name, auth_account_id: context[:account]&.id)
      if customer_app.save
        # Successful creation, return the created object with no errors
        {
          customer_app: customer_app,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          customer_app: nil,
          errors: customer_app.errors.full_messages
        }
      end
    end
  end
end
