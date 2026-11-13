# frozen_string_literal: true

module Elevenlabs
  module Agents
    module AnalysisItems
      module Types
        class UpdateAnalysisItemAttachmentsRequestModel < ::Elevenlabs::Internal::Types::Model
          field :source, -> { ::Elevenlabs::Types::AnalysisItemSource }, optional: false, nullable: false
          field :attach, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AnalysisItemAttachmentDestination] }, optional: true, nullable: false
          field :detach, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AnalysisItemAttachmentDestination] }, optional: true, nullable: false

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
end
