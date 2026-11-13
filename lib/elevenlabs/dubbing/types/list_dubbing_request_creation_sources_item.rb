# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Types
      module ListDubbingRequestCreationSourcesItem
        extend ::Elevenlabs::Internal::Types::Enum

        FLOW_NODE = :flow_node
        DUBBING_UI = :dubbing_ui
        DUBBING_API = :dubbing_api

        def self.load(str)
          coerce(::JSON.parse(str, symbolize_names: true))
        end

        def self.dump(value)
          coerced = coerce(value)
          ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
        end
      end
    end
  end
end
