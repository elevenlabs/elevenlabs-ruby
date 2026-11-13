# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Tests
      module Invocations
        class Client
          def initialize(client:)
            @client = client
          end

          # Lists all test invocations with pagination support and optional search filtering.
          def list(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
            query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
            query_params['created_by_user_id'] = params[:created_by_user_id] if params.key?(:created_by_user_id)
            query_params['test_id'] = params[:test_id] if params.key?(:test_id)
            query_params['start_time'] = params[:start_time] if params.key?(:start_time)
            query_params['end_time'] = params[:end_time] if params.key?(:end_time)
            query_params['version_id'] = params[:version_id] if params.key?(:version_id)
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['search'] = params[:search] if params.key?(:search)
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/convai/test-invocations',
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetTestInvocationsPageResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Gets a test invocation by ID.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/test-invocations/#{URI.encode_uri_component(params[:test_invocation_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetTestSuiteInvocationResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Updates the user-provided name of a test invocation.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Agents::Tests::Invocations::Types::UpdateTestSuiteInvocationRequestModel.new(params.except(:test_invocation_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PATCH',
              path: "v1/convai/test-invocations/#{URI.encode_uri_component(params[:test_invocation_id].to_s)}",
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetTestSuiteInvocationResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Cancels all pending runs in a test invocation.
          def cancel(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/convai/test-invocations/#{URI.encode_uri_component(params[:test_invocation_id].to_s)}/cancel",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            return if code.between?(200, 299)

            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end

          # Resubmits specific test runs from a test invocation.
          def resubmit(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Agents::Tests::Invocations::Types::ResubmitTestsRequestModel.new(params.except(:test_invocation_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/convai/test-invocations/#{URI.encode_uri_component(params[:test_invocation_id].to_s)}/resubmit",
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::JSON.parse(body) }
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
end
