module Types
  module Elements
  class HyperlinkType < Types::BaseObject
    graphql_name "Hyperlink"

    field :id, Integer, null: false
    field :url, String, null: false
    field :text, String, null: false
    field :target, String, null: false
    field :action, String, null: false
    field :updated_at, String, null: true
    field :created_at, String, null: true
  end
end
