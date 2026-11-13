# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Internal
    module WebSocket
      # @api private
      #
      # Builds the URL and headers of a WebSocket opening handshake.
      module Handshake
        module_function

        # Joins a base URL and a channel path, rewriting an `http(s)` scheme to `ws(s)`, and
        # appends the declared query parameters that are not nil, then the client's credential
        # parameters a declared one does not already name, then the request options'
        # `:additional_query_parameters`, which replace a parameter of the same name. An array
        # value repeats its key.
        #
        # @param base_url [String]
        # @param path [String]
        # @param query [Hash{String=>Object}]
        # @param client_query [Hash{String=>Object}]
        # @param request_options [Hash]
        # @return [String]
        def url(base_url:, path:, query: {}, client_query: {}, request_options: {})
          uri = URI.parse(base_url.to_s.sub(/\Ahttp(s?):/i) { "ws#{Regexp.last_match(1)}:" })
          uri.path = "#{uri.path.sub(%r{/+\z}, '')}#{path}"
          declared = stringify(query.compact).merge(stringify(client_query)) { |_name, value, _credential| value }
          merged = declared.merge(stringify(option(request_options, :additional_query_parameters)))
          parameters = URI.encode_www_form(merged.compact)
          uri.query = [uri.query, parameters].reject { |part| part.nil? || part.empty? }.join('&') unless parameters.empty?
          uri.to_s
        end

        # The headers of a handshake. The client's headers come first, then the client's
        # credentials; the declared headers that carry a value replace any of them with the same
        # name, whatever its case; the request options' `:additional_headers` then replace any
        # header the same way, and an additional header set to nil removes it. When a declared or
        # additional header names `Authorization`, even as nil, the credentials are never resolved,
        # so no token is fetched and no missing credential is reported.
        #
        # @param declared [Hash{String=>Object}]
        # @param client_headers [Hash{String=>String}]
        # @param credentials [#call] Returns the client's credential headers.
        # @param request_options [Hash]
        # @return [Hash{String=>String}]
        def headers(declared = {}, client_headers: {}, credentials: -> { {} }, request_options: {})
          declared = declared.compact
          additional = option(request_options, :additional_headers)
          merged = {}
          merge_headers(merged, client_headers.compact)
          per_connect_names = (declared.keys + additional.keys).map(&:to_s)
          merge_headers(merged, credentials.call) unless per_connect_names.any? { |name| name.casecmp?('Authorization') }
          merge_headers(merged, declared)
          merge_headers(merged, additional)
          merged
        end

        def merge_headers(merged, layer)
          layer.each do |name, value|
            merged.delete_if { |existing, _| existing.casecmp?(name.to_s) }
            merged[name.to_s] = value.to_s unless value.nil?
          end
        end

        def option(request_options, name)
          request_options&.dig(name) || request_options&.dig(name.to_s) || {}
        end

        def stringify(parameters)
          parameters.to_h { |name, value| [name.to_s, value] }
        end

        private_class_method :merge_headers, :option, :stringify
      end
    end
  end
end
