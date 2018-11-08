module Types
  class ElementType < Types::BaseScalar
    description "A hash for the element type"

    def self.coerce_input(input_value, context)
      input_value
    end

    def self.coerce_result(ruby_value, context)
      ruby_value
    end
  end
end
