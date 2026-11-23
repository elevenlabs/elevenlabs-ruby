# frozen_string_literal: true

module Elevenlabs
  module Reception
    class Client
      def initialize(client:, base_url: nil, environment: nil)
        @client = client
        @base_url = base_url
        @environment = environment
      end

      def services
        @services ||= Services::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def assets
        @assets ||= Assets::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def products
        @products ||= Products::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def staff
        @staff ||= Staff::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def receptionists
        @receptionists ||= Receptionists::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def phone_numbers
        @phone_numbers ||= PhoneNumbers::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def holidays
        @holidays ||= Holidays::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def locations
        @locations ||= Locations::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def business_profile
        @business_profile ||= BusinessProfile::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def knowledge_sources
        @knowledge_sources ||= KnowledgeSources::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def workspaces
        @workspaces ||= Workspaces::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def subscriptions
        @subscriptions ||= Subscriptions::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def tiers
        @tiers ||= Tiers::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def billing
        @billing ||= Billing::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end

      def team
        @team ||= Team::Client.new(client: @client, base_url: @base_url, environment: @environment)
      end
    end
  end
end
