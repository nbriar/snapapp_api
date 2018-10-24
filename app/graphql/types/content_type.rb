Types::ContentType = GraphQL::ObjectType.define do
  name "Content"
  field :name, types.String
  field :text, types.String
  field :tags, types[!Types::TagType]
end
