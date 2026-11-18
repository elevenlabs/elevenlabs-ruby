# frozen_string_literal: true

require_relative 'wire'

module Elevenlabs
  module AgentTools
    # The value of a webhook request header. Use the static constructors.
    class Header
      # @api private
      def initialize(model)
        @model = model
      end

      class << self
        # A fixed value.
        def value(text)
          new(text)
        end

        # A secret from the workspace's secret store, so the value never appears in the config.
        def secret(secret_id)
          new('secret_id' => secret_id)
        end

        # The value of a dynamic variable when the tool runs.
        def variable(name)
          new('variable_name' => name)
        end

        # A workspace environment variable, by label.
        def env_var(label)
          new('env_var_label' => label)
        end
      end

      # The header value in API wire format.
      def to_wire
        ToolWire.deep_copy(@model)
      end
    end

    # The auth connection a webhook tool authenticates with. Use the static constructors.
    class AuthConnection
      # @api private
      def initialize(model)
        @model = model
      end

      class << self
        # An auth connection from the workspace's store, by id.
        def id(auth_connection_id)
          new('auth_connection_id' => auth_connection_id)
        end

        # An environment variable of type auth connection, by label, resolved for the current environment.
        def env_var(label)
          new('env_var_label' => label)
        end
      end

      # The auth connection in API wire format.
      def to_wire
        ToolWire.deep_copy(@model)
      end
    end
  end
end
