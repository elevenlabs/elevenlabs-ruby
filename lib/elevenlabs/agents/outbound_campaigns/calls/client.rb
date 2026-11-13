# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Calls
        class Client
          def initialize(client:)
            @client = client
          end

          # List the calls of an outbound campaign, newest first: first contacts, retries, callbacks and redirects, whether queued, under way or done.
          def list(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['lead_id'] = params[:lead_id] if params.key?(:lead_id)
            query_params['status'] = params[:status] if params.key?(:status)
            query_params['call_result'] = params[:call_result] if params.key?(:call_result)
            query_params['stage'] = params[:stage] if params.key?(:stage)
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/outbound-campaigns/campaigns/#{URI.encode_uri_component(params[:campaign_id].to_s)}/calls",
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::CampaignCallsResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Download every call of a campaign, with its lead and conversation results, as CSV.
          #
          # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
          # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
          # start before the server has finished. `read` on the Enumerator returns the whole body as one
          # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
          # from this call.
          #
          # @return [Enumerator]
          def export(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['limit'] = params[:limit] if params.key?(:limit)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/outbound-campaigns/campaigns/#{URI.encode_uri_component(params[:campaign_id].to_s)}/export",
              query: query_params,
              accept: 'text/csv',
              request_options: request_options,
            )
            ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
              code = response.code.to_i
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
