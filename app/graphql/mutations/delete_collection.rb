module Mutations
  class DeleteCollection < Mutations::BaseMutation
    argument :id, Integer, required: true

    field :collection, Types::CollectionType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      collection = CollectionCreator.delete(id: id)

      if collection.destroyed?
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

    rescue ActiveRecord::RecordNotFound
      {
        collection: nil,
        errors: ["No Collection found with ID: #{id}"]
      }
    end
  end
end
