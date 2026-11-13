# frozen_string_literal: true

module Elevenlabs
  module Types
    module AsyncConversationMetadataPlatformMetadata
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :conversation_initiation_source
      member -> { ::Elevenlabs::Types::PlainPlatformMetadata }, key: 'plain_integration'
      member -> { ::Elevenlabs::Types::ZendeskPlatformMetadata }, key: 'zendesk_integration'

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
