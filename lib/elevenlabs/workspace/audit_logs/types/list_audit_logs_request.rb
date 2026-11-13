# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuditLogs
      module Types
        class ListAuditLogsRequest < ::Elevenlabs::Internal::Types::Model
          field :limit, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true

          field :time_from_unix_ms, -> { Integer }, optional: true, nullable: true

          field :time_to_unix_ms, -> { Integer }, optional: true, nullable: true

          field :actor_uid, -> { String }, optional: true, nullable: true

          field :class_name, -> { ::Elevenlabs::Types::AuditClassName }, optional: true, nullable: true

          field :activity_name, -> { ::Elevenlabs::Types::AuditActivityName }, optional: true, nullable: true
        end
      end
    end
  end
end
