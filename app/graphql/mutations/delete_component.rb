module Mutations
  class DeleteComponent < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      component = Component.find(id)
      if component.destroy!
        # Successful deletion, return the deleted object with no errors
        {
          component: component,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          component: nil,
          errors: component.errors.full_messages
        }
      end

    rescue ActiveRecord::RecordNotFound
      {
        component: nil,
        errors: ["No Component found with ID: #{id}"]
      }
    end
  end
end
