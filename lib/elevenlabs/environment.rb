# frozen_string_literal: true

module Elevenlabs
  module Environment
    DEFAULT = { base: 'https://api.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze

    PRODUCTION = { base: 'https://api.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze

    PRODUCTION_US = { base: 'https://api.us.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze

    PRODUCTION_EU = { base: 'https://api.eu.residency.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze

    PRODUCTION_INDIA = { base: 'https://api.in.residency.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze

    PRODUCTION_SINGAPORE = { base: 'https://api.sg.residency.elevenlabs.io', production: 'wss://api.elevenlabs.io', production_us: 'wss://api.us.elevenlabs.io', production_eu: 'wss://api.eu.residency.elevenlabs.io', production_india: 'wss://api.in.residency.elevenlabs.io', production_singapore: 'wss://api.sg.residency.elevenlabs.io' }.freeze
  end
end
