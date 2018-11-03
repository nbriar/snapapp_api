module Mutations
  class CreatePage < Mutations::BaseMutation
    null true

    argument :title, String, required: true
    argument :app_id, Integer, required: true

    field :page, Types::PageType, null: true
    field :errors, [String], null: false

    def resolve(title:, app_id:)

      route = title.dasherize
      page = Page.new(title: title, route: route, customer_app_id: app_id)
      if page.save
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
    end
  end
end
