# frozen_string_literal: true

module Elevenlabs
  module Internal
    module Types
      module Unknown
        include ::Elevenlabs::Internal::Types::Type

        def coerce(value)
          value
        end
      end
    end
  end
end
