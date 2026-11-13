# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Dashboard
      module Settings
        module Types
          module PatchConvAiDashboardSettingsRequestChartsItem
            extend ::Elevenlabs::Internal::Types::Union

            discriminant :type
            member -> { ::Elevenlabs::Types::DashboardCallSuccessChartModel }, key: 'call_success'
            member -> { ::Elevenlabs::Types::DashboardCriteriaChartModel }, key: 'criteria'
            member -> { ::Elevenlabs::Types::DashboardDataCollectionChartModel }, key: 'data_collection'

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
