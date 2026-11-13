# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Types
      class ListDubbingRequest < ::Elevenlabs::Internal::Types::Model
        field :cursor, -> { String }, optional: true, nullable: true

        field :page_size, -> { Integer }, optional: true, nullable: true

        field :dubbing_status, -> { ::Elevenlabs::Dubbing::Types::ListDubbingRequestDubbingStatus }, optional: true, nullable: true

        field :dubbing_statuses, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Dubbing::Types::ListDubbingRequestDubbingStatusesItem] }, optional: true, nullable: true

        field :dubbing_models, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Dubbing::Types::ListDubbingRequestDubbingModelsItem] }, optional: true, nullable: true

        field :target_language_codes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :creation_sources, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Dubbing::Types::ListDubbingRequestCreationSourcesItem] }, optional: true, nullable: true

        field :filter_by_creator, -> { ::Elevenlabs::Dubbing::Types::ListDubbingRequestFilterByCreator }, optional: true, nullable: true

        field :order_by, -> { ::Elevenlabs::Dubbing::Types::ListDubbingRequestOrderBy }, optional: true, nullable: true

        field :order_direction, -> { ::Elevenlabs::Dubbing::Types::ListDubbingRequestOrderDirection }, optional: true, nullable: true
      end
    end
  end
end
