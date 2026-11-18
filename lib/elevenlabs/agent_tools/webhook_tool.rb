# frozen_string_literal: true

require_relative 'errors'
require_relative 'schema'
require_relative 'tool'
require_relative 'validate'
require_relative 'wire'

module Elevenlabs
  module AgentTools
    # A tool the server runs by calling an HTTP endpoint.
    class WebhookTool < Tool
      OPTIONS = (COMMON_OPTIONS + %w[
        dynamic_variable_placeholders execution_mode content_type response_filter follow_redirects
        follow_redirects_allowed_domains
      ]).freeze
      # Option keys stored under api_schema rather than on the tool config.
      API_SCHEMA_OPTIONS = %w[content_type response_filter].freeze
      # Environment variable templates in a URL aren't path placeholders.
      ENV_VAR_TEMPLATE = /\{\{system__env_[a-z][a-z0-9_]*\}\}/
      PLACEHOLDER = /\{([^{}]+)\}/
      BODY_METHODS = %w[POST PUT PATCH].freeze

      # @api private — use Tool.webhook. +api+ is the api_schema fields not kept in their own fields below.
      def initialize(config, api)
        super(config)
        @api = api
        @path_params = {}
        @query = nil
        @body = nil
        @response = nil
        @headers = {}
      end

      # @api private
      def self.load(config, api_schema)
        api = api_schema.except('path_params_schema', 'query_params_schema', 'request_body_schema',
                                'response_body_schema', 'request_headers')
        tool = new(config, api)
        tool.send(:load_api_schema, api_schema)
        tool
      end

      def kind
        'webhook'
      end

      # Sends a GET to +url+. {name} placeholders in the URL are filled from path params.
      def get(url)
        request('GET', url)
      end

      # Sends a POST to +url+.
      def post(url)
        request('POST', url)
      end

      # Sends a PUT to +url+.
      def put(url)
        request('PUT', url)
      end

      # Sends a PATCH to +url+.
      def patch(url)
        request('PATCH', url)
      end

      # Sends a DELETE to +url+.
      def delete(url)
        request('DELETE', url)
      end

      # Sets the path param +name+, filling the {name} placeholder in the URL. Literal schemas only.
      def path_param(name, schema)
        @path_params[name] = schema
        self
      end

      # Sets the query param +name+. Required unless the schema is optional. Literal schemas only.
      def query_param(name, schema)
        @query = (@query || Schema.object).property(name, schema)
        self
      end

      # Sets the request body schema. Must be an object.
      def body(schema)
        @body = schema
        self
      end

      # Sets the response body schema. Must be an object.
      def response(schema)
        @response = schema
        self
      end

      # Sets the request header +name+ to a Header.
      def header(name, value)
        @headers[name] = value.to_wire
        self
      end

      # Authenticates requests with an AuthConnection.
      def auth(connection)
        @api['auth_connection'] = connection.to_wire
        self
      end

      # Stores the value at +value_path+ in the response (dot notation, e.g. "order.status") in the dynamic
      # variable +variable+. +sanitize+ removes the value from the tool response before the LLM and the
      # transcript see it; +preserve_native_type+ stores lists and objects as they are instead of as JSON
      # strings.
      def assign(variable, value_path, sanitize: nil, preserve_native_type: nil)
        assignment = { 'source' => 'response', 'dynamic_variable' => variable, 'value_path' => value_path }
        assignment['sanitize'] = sanitize unless sanitize.nil?
        assignment['preserve_native_type'] = preserve_native_type unless preserve_native_type.nil?
        @config['assignments'] = (@config['assignments'] || []) + [assignment]
        self
      end

      # Removes the path param +name+.
      def remove_path_param(name)
        @path_params.delete(name)
        self
      end

      # Removes the query param +name+.
      def remove_query_param(name)
        @query = @query&.without(name)
        self
      end

      # Removes the request header +name+.
      def remove_header(name)
        @headers.delete(name)
        self
      end

      # Removes every assignment to +variable+.
      def remove_assignment(variable)
        assignments = @config['assignments']
        @config['assignments'] = assignments.reject { |a| a['dynamic_variable'] == variable } unless assignments.nil?
        self
      end

      # The request body schema, for editing and setting again with body.
      def body_schema
        @body
      end

      # The response body schema, for editing and setting again with response.
      def response_schema
        @response
      end

      protected

      def allowed_options
        OPTIONS
      end

      def set_option(key, value)
        if API_SCHEMA_OPTIONS.include?(key)
          @api[key] = value
        else
          super
        end
      end

      def validate_tool
        issues = []
        url = @api['url']
        issues << ToolIssue.error('missing_url', nil, 'Set the method and URL with get, post, put, patch or delete') if url.nil?
        check_path_params(url, issues)
        check_query(issues)
        check_bodies(issues)
        check_duplicates(issues)
        check_headers(issues)
        check_options(issues)
        issues
      end

      def to_wire
        api = ToolWire.deep_copy(@api)
        api['path_params_schema'] = @path_params.transform_values(&:to_wire) unless @path_params.empty?
        query = @query&.to_wire
        if !query.nil? && query.key?('properties')
          api['query_params_schema'] = { 'properties' => query['properties'] }
          api['query_params_schema']['required'] = query['required'] if query.key?('required')
        end
        api['request_body_schema'] = @body.to_wire unless @body.nil?
        api['response_body_schema'] = @response.to_wire unless @response.nil?
        api['request_headers'] = ToolWire.deep_copy(@headers) unless @headers.empty?
        @config.merge('type' => 'webhook', 'api_schema' => api)
      end

      private

      def load_api_schema(api_schema)
        (api_schema['path_params_schema'] || {}).each { |name, model| @path_params[name] = Schema.from_wire(model) }
        query = api_schema['query_params_schema']
        @query = Schema.from_wire(query, kind: 'object') unless query.nil?
        body = api_schema['request_body_schema']
        @body = Schema.from_wire(body, kind: 'object') unless body.nil?
        response = api_schema['response_body_schema']
        @response = Schema.from_wire(response, kind: 'object') unless response.nil?
        (api_schema['request_headers'] || {}).each { |name, value| @headers[name] = value }
      end

      def request(method, url)
        @api['method'] = method
        @api['url'] = url
        self
      end

      # As the API does: env var templates aren't placeholders, and the auth connection fills
      # auth_resolved_params.
      def check_path_params(url, issues)
        placeholders = (url || '').gsub(ENV_VAR_TEMPLATE, 'env').scan(PLACEHOLDER).map(&:first)
        auth_resolved = @api['auth_resolved_params'] || []
        placeholders.each do |name|
          next if @path_params.key?(name) || auth_resolved.include?(name)

          issues << ToolIssue.error('missing_path_param', "path_params.#{name}",
                                    "The URL has {#{name}} but no path_param(\"#{name}\")")
        end
        @path_params.each do |name, schema|
          path = "path_params.#{name}"
          if !url.nil? && !placeholders.include?(name)
            issues << ToolIssue.error('unknown_path_param', path, "path_param(\"#{name}\") has no {#{name}} in the URL")
          elsif auth_resolved.include?(name)
            issues << ToolIssue.error('unknown_path_param', path,
                                      "{#{name}} is filled by the auth connection, not a path_param")
          end
          unless Validate.literal?(schema.kind)
            issues << ToolIssue.error('param_not_literal', path,
                                      "Path param \"#{name}\" must be a string, integer, number or bool")
          end
          Validate.check_schema(schema, path, true, issues)
        end
      end

      def check_query(issues)
        return if @query.nil?

        @query.property_names.each do |name|
          schema = @query.property_schema(name)
          path = "query.#{name}"
          unless Validate.literal?(schema.kind)
            issues << ToolIssue.error('param_not_literal', path,
                                      "Query param \"#{name}\" must be a string, integer, number or bool")
          end
          Validate.check_schema(schema, path, true, issues)
        end
      end

      def check_bodies(issues)
        { 'body' => @body, 'response' => @response }.each do |label, schema|
          next if schema.nil?

          issues << ToolIssue.error('body_not_object', label, "The #{label} schema must be an object") unless schema.kind == 'object'
          Validate.check_schema(schema, label, false, issues)
        end
        method = @api['method']
        issues << ToolIssue.error('body_not_allowed', 'body', "A GET request can't have a body") if method == 'GET' && !@body.nil?
        return unless BODY_METHODS.include?(method) && @body.nil?

        issues << ToolIssue.error('missing_body', 'body', "A #{method} request needs a body")
      end

      def check_duplicates(issues)
        where = {}
        [
          ['path_params', @path_params.keys],
          ['query', @query.nil? ? [] : @query.property_names],
          ['body', @body.is_a?(ObjectSchema) ? @body.property_names : []],
        ].each do |location, names|
          names.each do |name|
            first = where[name]
            if first.nil?
              where[name] = location
            else
              issues << ToolIssue.error(
                'duplicate_param', "#{location}.#{name}",
                "\"#{name}\" is in both #{first} and #{location}; param names must be unique across path, query and body"
              )
            end
          end
        end
      end

      def check_headers(issues)
        seen = {}
        @headers.each_key do |name|
          other = seen[name.downcase]
          unless other.nil?
            issues << ToolIssue.error('duplicate_header', "headers.#{name}",
                                      "Headers \"#{other}\" and \"#{name}\" differ only in case")
          end
          seen[name.downcase] = name
        end
      end

      def check_options(issues)
        timeout = @config['response_timeout_secs']
        if timeout.is_a?(::Numeric) && (timeout < 5 || timeout > 300)
          issues << ToolIssue.error('invalid_option', 'response_timeout_secs',
                                    "A webhook tool's response_timeout_secs must be 5–300")
        end
        domains = @config['follow_redirects_allowed_domains']
        return unless @config['follow_redirects'] == true && (domains.nil? || domains.empty?)

        issues << ToolIssue.error('invalid_option', 'follow_redirects',
                                  'follow_redirects needs follow_redirects_allowed_domains')
      end
    end
  end
end
