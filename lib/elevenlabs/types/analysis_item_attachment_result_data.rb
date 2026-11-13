# frozen_string_literal: true

module Elevenlabs
  module Types
    class AnalysisItemAttachmentResultData < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: false, nullable: false
      field :action, -> { ::Elevenlabs::Types::AnalysisItemAttachmentAction }, optional: false, nullable: false
      field :changed, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
