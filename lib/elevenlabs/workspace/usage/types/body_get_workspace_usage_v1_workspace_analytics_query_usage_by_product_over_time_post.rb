# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Usage
      module Types
        class BodyGetWorkspaceUsageV1WorkspaceAnalyticsQueryUsageByProductOverTimePost < ::Elevenlabs::Internal::Types::Model
          field :start_time, -> { Integer }, optional: false, nullable: false
          field :end_time, -> { Integer }, optional: false, nullable: false
          field :interval_seconds, -> { Integer }, optional: true, nullable: false
          field :group_by, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Workspace::Usage::Types::BodyGetWorkspaceUsageV1WorkspaceAnalyticsQueryUsageByProductOverTimePostGroupByItem] }, optional: true, nullable: true
          field :filters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ColumnFilter] }, optional: true, nullable: true
          field :time_zone, -> { String }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_integer!(start_time, 'start_time', min: 1_577_836_800_000)
            ::Elevenlabs::Validator.validate_integer!(end_time, 'end_time', min: 1_577_836_800_000)
            ::Elevenlabs::Validator.validate_integer!(interval_seconds, 'interval_seconds', min: 1)
          end

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
