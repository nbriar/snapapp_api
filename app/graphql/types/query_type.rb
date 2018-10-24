Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :content do
    type Types::ContentType
    argument :id, !types.ID
    description "Find content by ID"
    resolve ->(obj, args, ctx) { Content.find(args["id"]) }
  end
end
