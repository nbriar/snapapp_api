module Types
  class ComponentInputType < Types::BaseInputObject
    graphql_name "ComponentInput"

    argument :name, String, required: true
    argument :element, Types::ElementType, required: true
  end
end
