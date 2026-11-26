# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    class Client
      def initialize(client:)
        @client = client
      end

      def requesters
        @requesters ||= Requesters::Client.new(client: @client)
      end

      def tags
        @tags ||= Tags::Client.new(client: @client)
      end

      def sla_policies
        @sla_policies ||= SLAPolicies::Client.new(client: @client)
      end

      def tickets
        @tickets ||= Tickets::Client.new(client: @client)
      end
    end
  end
end
