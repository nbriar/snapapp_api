module Mutations
  class UpdateComponent < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true
    argument :name, String, required: false
    argument :element, Types::ElementType, required: false

    field :component, Types::ComponentType, null: true
    field :errors, [String], null: false

    def resolve(id:, name: nil, element: nil)
      if name.blank? && element.blank?
        return  {
          component: nil,
          errors: ["Must supply either name or element for update"]
        }
      end
      component = ComponentCreator.update(id: id, name: name, element: element.symbolize_keys)
      if component.errors.blank?
        # Successful update, return the updated object with no errors
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
