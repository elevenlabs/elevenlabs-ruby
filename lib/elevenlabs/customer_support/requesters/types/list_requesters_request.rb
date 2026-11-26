# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Requesters
      module Types
        class ListRequestersRequest < ::Elevenlabs::Internal::Types::Model
          field :ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
