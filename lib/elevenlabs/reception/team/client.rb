# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      class Client
        def initialize(client:, base_url: nil, environment: nil)
          @client = client
          @base_url = base_url
          @environment = environment
        end

        def members
          @members ||= Members::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end

        def invites
          @invites ||= Invites::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end
      end
    end
  end
end
