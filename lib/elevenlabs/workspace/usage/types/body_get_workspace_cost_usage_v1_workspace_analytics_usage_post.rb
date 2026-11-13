# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Usage
      module Types
        class BodyGetWorkspaceCostUsageV1WorkspaceAnalyticsUsagePost < ::Elevenlabs::Internal::Types::Model
          field :start_time, -> { Integer }, optional: false, nullable: false
          field :end_time, -> { Integer }, optional: false, nullable: false
          field :interval_seconds, -> { Integer }, optional: false, nullable: false
          field :group_by, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Workspace::Usage::Types::BodyGetWorkspaceCostUsageV1WorkspaceAnalyticsUsagePostGroupByItem] }, optional: true, nullable: true
          field :filters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MetronomeUsageColumnFilter] }, optional: true, nullable: true

          def validate!
            ::Elevenlabs::Validator.validate_integer!(start_time, 'start_time', min: 1_577_836_800_000)
            ::Elevenlabs::Validator.validate_integer!(end_time, 'end_time', min: 1_577_836_800_000)
            ::Elevenlabs::Validator.validate_integer!(interval_seconds, 'interval_seconds', min: 86_400, multiple_of: 86_400)
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
