# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      class SearchVoicesRequest < ::Elevenlabs::Internal::Types::Model
        field :next_page_token, -> { String }, optional: true, nullable: true

        field :page_size, -> { Integer }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true

        field :sort, -> { String }, optional: true, nullable: true

        field :sort_direction, -> { String }, optional: true, nullable: true

        field :voice_type, -> { String }, optional: true, nullable: true

        field :category, -> { String }, optional: true, nullable: true

        field :fine_tuning_state, -> { String }, optional: true, nullable: true

        field :collection_id, -> { String }, optional: true, nullable: true

        field :gender, -> { String }, optional: true, nullable: true

        field :age, -> { String }, optional: true, nullable: true

        field :language, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :accent, -> { String }, optional: true, nullable: true

        field :use_cases, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :min_notice_period_days, -> { Integer }, optional: true, nullable: true

        field :include_custom_rates, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :include_live_moderated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :high_quality, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :include_total_count, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :voice_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      end
    end
  end
end
