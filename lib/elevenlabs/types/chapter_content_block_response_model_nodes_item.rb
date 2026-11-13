# frozen_string_literal: true

module Elevenlabs
  module Types
    module ChapterContentBlockResponseModelNodesItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::ChapterContentBlockTtsNodeResponseModel }, key: 'tts_node'
      member -> { ::Elevenlabs::Types::ChapterContentBlockExtendableNodeResponseModel }, key: '_other'

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
