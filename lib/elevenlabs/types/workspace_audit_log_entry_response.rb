# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkspaceAuditLogEntryResponse < ::Elevenlabs::Internal::Types::Model
      field :metadata, -> { Object }, optional: true, nullable: false
      field :time, -> { Integer }, optional: true, nullable: false
      field :activity_id, -> { ::Elevenlabs::Types::WorkspaceAuditLogEntryResponseActivityID }, optional: false, nullable: false
      field :activity_name, -> { String }, optional: false, nullable: false
      field :category_name, -> { String }, optional: true, nullable: false
      field :category_uid, -> { Integer }, optional: true, nullable: false
      field :class_name, -> { String }, optional: true, nullable: false
      field :class_uid, -> { Integer }, optional: true, nullable: false
      field :severity_id, -> { ::Elevenlabs::Types::SeverityID }, optional: true, nullable: false
      field :status_id, -> { ::Elevenlabs::Types::StatusID }, optional: false, nullable: false
      field :actor, -> { ::Elevenlabs::Types::ActorModel }, optional: false, nullable: false
      field :device, -> { ::Elevenlabs::Types::DeviceModel }, optional: true, nullable: true
      field :http_request, -> { ::Elevenlabs::Types::HTTPRequestModel }, optional: true, nullable: true
      field :message, -> { String }, optional: false, nullable: false
      field :unmapped, -> { Object }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :time_dt, -> { String }, optional: true, nullable: false
      field :type_uid, -> { Integer }, optional: true, nullable: false
      field :type_name, -> { String }, optional: true, nullable: false

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
