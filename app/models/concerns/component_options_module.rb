module ComponentOptionsModule
  extend ActiveSupport::Concern

  included do
    has_one :component_option
  end

  module ClassMethods
    def field_definitions
      {}
    end
  end
end
