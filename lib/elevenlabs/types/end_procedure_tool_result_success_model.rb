# frozen_string_literal: true

module Elevenlabs
  module Types
    class EndProcedureToolResultSuccessModel < ::Elevenlabs::Internal::Types::Model
      field :result_type, -> { ::Elevenlabs::Types::EndProcedureToolResultSuccessModelResultType }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::EndProcedureToolResultSuccessModelStatus }, optional: true, nullable: false
      field :procedure_id, -> { String }, optional: false, nullable: false
      field :procedure_name, -> { String }, optional: false, nullable: false
      field :message, -> { String }, optional: true, nullable: false

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
