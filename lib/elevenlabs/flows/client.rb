# frozen_string_literal: true

module Elevenlabs
  module Flows
    class Client
      def initialize(client:, base_url: nil, environment: nil)
        @client = client
        @base_url = base_url
        @environment = environment
      end

      def video
        @video ||= Video::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def image
        @image ||= Image::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def text_to_speech
        @text_to_speech ||= TextToSpeech::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def templates
        @templates ||= Templates::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end
    end
  end
end
