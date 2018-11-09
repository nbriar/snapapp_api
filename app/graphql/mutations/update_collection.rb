module Mutations
  class UpdateCollection < Mutations::BaseMutation
    argument :id, Integer, required: true
    argument :name, String, required: true

    field :collection, Types::CollectionType, null: true
    field :errors, [String], null: false

    def resolve(id:, name:)
      collection = CollectionCreator.update(id: id, name: name)

      if collection.errors.blank?
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
