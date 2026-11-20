# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      class Client
        def initialize(client:)
          @client = client
        end

        def members
          @members ||= Members::Client.new(client: @client)
        end

        def invites
          @invites ||= Invites::Client.new(client: @client)
        end
      end
    end
  end
end
