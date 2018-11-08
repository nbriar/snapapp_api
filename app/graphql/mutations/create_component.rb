module Mutations
  class CreateComponent < Mutations::BaseMutation
    null true

    argument :app_id, Integer, required: true
    argument :collection_id, Integer, required: false
    argument :name, String, required: true
    argument :element, Types::ElementType, required: true

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(app_id:, name:,element:, collection_id: nil )
      component = ComponentCreator.create(
        name: name,
        collection_id: collection_id,
        app_id: app_id,
        element: element.symbolize_keys
      )

      if component.id.present?
        # Successful creation, return the created object with no errors
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
    end
  end
end
