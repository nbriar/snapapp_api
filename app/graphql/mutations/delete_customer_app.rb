module Mutations
  class DeleteCustomerApp < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true

    field :customer_app, Types::CustomerAppType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      customer_app = CustomerApp.find(id)
      if customer_app.destroy
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
