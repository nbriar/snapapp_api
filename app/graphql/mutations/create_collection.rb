module Mutations
  class CreateCollection < Mutations::BaseMutation
    argument :app_id, Integer, required: true
    argument :name, String, required: true
    argument :components, [Types::ComponentInputType], required: true

    field :collection, Types::CollectionType, null: true
    field :errors, [String], null: false

    def resolve(app_id:, name:, components: )
      collection = CollectionCreator.create(
        app_id: app_id,
        name: name,
        components: components,
      )

      if collection.id.present?
        # Successful creation, return the created object with no errors
        {
          collection: collection,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          collection: nil,
          errors: collection.errors.full_messages
        }
      end
    end
  end
end
