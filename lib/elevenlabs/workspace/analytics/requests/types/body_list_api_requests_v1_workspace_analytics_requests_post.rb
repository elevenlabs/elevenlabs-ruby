# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Analytics
      module Requests
        module Types
          class BodyListAPIRequestsV1WorkspaceAnalyticsRequestsPost < ::Elevenlabs::Internal::Types::Model
            field :start_time, -> { Integer }, optional: true, nullable: true
            field :end_time, -> { Integer }, optional: true, nullable: true
            field :limit, -> { Integer }, optional: true, nullable: false
            field :sort, -> { ::Elevenlabs::Workspace::Analytics::Requests::Types::BodyListAPIRequestsV1WorkspaceAnalyticsRequestsPostSort }, optional: true, nullable: true
            field :filters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ColumnFilter] }, optional: true, nullable: true
            field :search, -> { String }, optional: true, nullable: true

            def validate!
              ::Elevenlabs::Validator.validate_integer!(start_time, 'start_time', min: 1_577_836_800_000)
              ::Elevenlabs::Validator.validate_integer!(end_time, 'end_time', min: 1_577_836_800_000)
              ::Elevenlabs::Validator.validate_integer!(limit, 'limit', min: 1, max: 1000)
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
end
