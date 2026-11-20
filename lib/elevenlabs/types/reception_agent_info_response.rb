# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionAgentInfoResponse < ::Elevenlabs::Internal::Types::Model
      field :business_name, -> { String }, optional: true, nullable: false
      field :business_country, -> { String }, optional: true, nullable: true
      field :business_description, -> { String }, optional: true, nullable: false
      field :timezone, -> { String }, optional: true, nullable: false
      field :currency, -> { ::Elevenlabs::Types::ReceptionAgentInfoResponseCurrency }, optional: true, nullable: false
      field :operating_hours, -> { ::Elevenlabs::Types::WorkingHours }, optional: true, nullable: false
      field :tool_call_sound, -> { ::Elevenlabs::Types::ToolCallSoundType }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :created_at_unix, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix, -> { Integer }, optional: false, nullable: false
      field :workspace_now, -> { ::Elevenlabs::Types::WorkspaceNow }, optional: true, nullable: false

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
