module Mutations
  class DeletePage < Mutations::BaseMutation
    null true

    argument :id, Integer, required: true

    field :page, Types::PageType, null: true
    field :errors, [String], null: false

    def resolve(id:)
      page = Page.find(id)
      if page.destroy!
        # Successful creation, return the created object with no errors
        {
          page: page,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          page: nil,
          errors: page.errors.full_messages
        }
      end

    rescue ActiveRecord::RecordNotFound
      {
        page: nil,
        errors: ["No Page found with ID: #{id}"]
      }
    end
  end
end
