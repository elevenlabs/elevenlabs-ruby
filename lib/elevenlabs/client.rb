# frozen_string_literal: true

module Elevenlabs
  class Client
    DEFAULT_BASE_URL = Environment::DEFAULT

    def initialize(api_key: ENV.fetch('ELEVENLABS_API_KEY', nil), base_url: nil, max_retries: 2, timeout: 60, allow_insecure_http: false)
      headers = { 'X-Fern-Language' => 'Ruby' }
      headers['xi-api-key'] = api_key unless api_key.nil?
      @raw_client = Internal::Http::RawClient.new(
        base_url: base_url || DEFAULT_BASE_URL,
        headers: headers,
        max_retries: max_retries,
        timeout: timeout,
        allow_insecure_http: allow_insecure_http,
        websocket: { base_url: base_url },
      )
    end

    def history
      @history ||= History::Client.new(client: @raw_client)
    end

    def text_to_sound_effects
      @text_to_sound_effects ||= TextToSoundEffects::Client.new(client: @raw_client)
    end

    def audio_isolation
      @audio_isolation ||= AudioIsolation::Client.new(client: @raw_client)
    end

    def audio_effects
      @audio_effects ||= AudioEffects::Client.new(client: @raw_client)
    end

    def samples
      @samples ||= Samples::Client.new(client: @raw_client)
    end

    def voices
      @voices ||= Voices::Client.new(client: @raw_client)
    end

    def text_to_speech
      @text_to_speech ||= TextToSpeech::Client.new(client: @raw_client)
    end

    def text_to_dialogue
      @text_to_dialogue ||= TextToDialogue::Client.new(client: @raw_client)
    end

    def speech_to_speech
      @speech_to_speech ||= SpeechToSpeech::Client.new(client: @raw_client)
    end

    def text_to_voice
      @text_to_voice ||= TextToVoice::Client.new(client: @raw_client)
    end

    def user
      @user ||= User::Client.new(client: @raw_client)
    end

    def studio
      @studio ||= Studio::Client.new(client: @raw_client)
    end

    def dubbing
      @dubbing ||= Dubbing::Client.new(client: @raw_client)
    end

    def models
      @models ||= Models::Client.new(client: @raw_client)
    end

    def audio_native
      @audio_native ||= AudioNative::Client.new(client: @raw_client)
    end

    def pronunciation_dictionaries
      @pronunciation_dictionaries ||= PronunciationDictionaries::Client.new(client: @raw_client)
    end

    def workspaces
      @workspaces ||= Workspaces::Client.new(client: @raw_client)
    end

    def workspace
      @workspace ||= Workspace::Client.new(client: @raw_client)
    end

    def service_accounts
      @service_accounts ||= ServiceAccounts::Client.new(client: @raw_client)
    end

    def webhooks
      @webhooks ||= Webhooks::Client.new(client: @raw_client)
    end

    def music
      @music ||= Music::Client.new(client: @raw_client)
    end

    def speech_to_text
      @speech_to_text ||= SpeechToText::Client.new(client: @raw_client)
    end

    def tokens
      @tokens ||= Tokens::Client.new(client: @raw_client)
    end

    def forced_alignment
      @forced_alignment ||= ForcedAlignment::Client.new(client: @raw_client)
    end

    def agents
      @agents ||= Agents::Client.new(client: @raw_client)
    end

    def speech_engine
      @speech_engine ||= SpeechEngine::Client.new(client: @raw_client)
    end

    def environment_variables
      @environment_variables ||= EnvironmentVariables::Client.new(client: @raw_client)
    end

    def environments
      @environments ||= Environments::Client.new(client: @raw_client)
    end

    def productions
      @productions ||= Productions::Client.new(client: @raw_client)
    end

    def flows
      @flows ||= Flows::Client.new(client: @raw_client)
    end

    def assets
      @assets ||= Assets::Client.new(client: @raw_client)
    end

    def text_to_dialogue_multi_context
      @text_to_dialogue_multi_context ||= TextToDialogueMultiContext::Client.new(client: @raw_client)
    end

    def text_to_speech_multi_context
      @text_to_speech_multi_context ||= TextToSpeechMultiContext::Client.new(client: @raw_client)
    end

    def translation
      @translation ||= Translation::Client.new(client: @raw_client)
    end
  end
end
