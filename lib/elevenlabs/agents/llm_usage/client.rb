# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module LlmUsage
      class Client
        def initialize(client:)
          @client = client
        end

        # Calculates expected number of LLM tokens needed for the specified agent.
        def calculate_for_agent(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::LlmUsage::Types::LlmUsageCalculatorRequestModel.new(params.except(:agent_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agent/#{URI.encode_uri_component(params[:agent_id].to_s)}/llm-usage/calculate",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::LlmUsageCalculatorResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Returns a list of LLM models and the expected cost for using them based on the provided values.
        def calculate(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::LlmUsage::Types::LlmUsageCalculatorPublicRequestModel.new(params)
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/convai/llm-usage/calculate',
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::LlmUsageCalculatorResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end
      end
    end
  end
end
