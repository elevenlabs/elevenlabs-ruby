# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Types
      class GetSharedVoicesRequest < ::Elevenlabs::Internal::Types::Model
        field :page_size, -> { Integer }, optional: true, nullable: true

        field :category, -> { ::Elevenlabs::Voices::Types::GetSharedVoicesRequestCategory }, optional: true, nullable: true

        field :gender, -> { String }, optional: true, nullable: true

        field :age, -> { String }, optional: true, nullable: true

        field :accent, -> { String }, optional: true, nullable: true

        field :language, -> { String }, optional: true, nullable: true

        field :locale, -> { String }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true

        field :use_cases, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :descriptives, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :featured, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :min_notice_period_days, -> { Integer }, optional: true, nullable: true

        field :include_custom_rates, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :include_live_moderated, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :reader_app_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :owner_id, -> { String }, optional: true, nullable: true

        field :sort, -> { ::Elevenlabs::Voices::Types::GetSharedVoicesRequestSort }, optional: true, nullable: true

        field :page, -> { Integer }, optional: true, nullable: true
      end
    end
  end
end
