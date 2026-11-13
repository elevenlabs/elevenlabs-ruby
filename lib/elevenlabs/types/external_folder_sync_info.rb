# frozen_string_literal: true

module Elevenlabs
  module Types
    class ExternalFolderSyncInfo < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::ExternalSyncProvider }, optional: false, nullable: false
      field :source_entity_id, -> { String }, optional: false, nullable: false
      field :integration_connection_id, -> { String }, optional: false, nullable: false
      field :root_folder_id, -> { String }, optional: true, nullable: true
      field :sync_cursor, -> { String }, optional: true, nullable: true
      field :last_sync_at, -> { Integer }, optional: true, nullable: true

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
