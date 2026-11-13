# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProjectSnapshotResponse < ::Elevenlabs::Internal::Types::Model
      field :project_snapshot_id, -> { String }, optional: false, nullable: false
      field :project_id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :audio_upload, -> { Object }, optional: true, nullable: true
      field :zip_upload, -> { Object }, optional: true, nullable: true

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
