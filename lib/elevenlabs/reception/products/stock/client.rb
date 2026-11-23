# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module Products
      module Stock
        class Client
          def initialize(client:, base_url: nil, environment: nil)
            @client = client
            @base_url = base_url
            @environment = environment
          end

          # Set the on-hand quantity of a counted product at one location. Rejected with a 409 if it changed since `expected_on_hand` was read.
          def set(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Products::Stock::Types::ReceptionUpdateProductStockRequest.new(params.except(:product_id, :xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PATCH',
              path: "v1/reception/products/#{URI.encode_uri_component(params[:product_id].to_s)}/stock",
              body: request_body.to_h,
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionProduct.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Add to or subtract from the on-hand quantity of a counted product at one location, without overwriting orders taken at the same time.
          def adjust(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Products::Stock::Types::ReceptionAdjustProductStockRequest.new(params.except(:product_id, :xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/reception/products/#{URI.encode_uri_component(params[:product_id].to_s)}/stock/adjust",
              body: request_body.to_h,
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionProduct.load(body) }
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
end
