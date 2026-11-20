# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class SpeechEngineWireTest < Minitest::Test
  # Class-scoped, not top-level: `rake test` loads every generated wire-test file into ONE Ruby
  # process, and a top-level `BASE_URL = ...` in each would redefine the same global constant
  # repeatedly (harmless here since the value never differs, but still a real
  # "already initialized constant" warning on every run after the first file).
  BASE_URL = 'https://wire-test.example.com'

  def setup
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
  end

  private

  # Preserve every value for repeated array query keys instead of collapsing to the last one.
  def wire_test_query(captured_uri)
    URI.decode_www_form(captured_uri.query.to_s).each_with_object({}) do |(key, value), query|
      (query[key] ||= []) << value
    end
  end

  # WebMock normalizes a captured request's header keys to Title-Case (`Api-Key`,
  # `Authorization`) regardless of the exact casing the SDK's own code used when it set the
  # header (e.g. `headers['api-key'] = ...`) -- confirmed against a real customer spec, where
  # every wire test asserting a non-canonically-cased header failed with `Actual: nil` despite
  # the SDK sending the header correctly. HTTP headers are case-insensitive by spec (RFC 7230
  # §3.2), so look them up that way rather than assuming any particular casing survives WebMock's
  # capture.
  def wire_test_header(headers, key)
    headers.find { |k, _| k.casecmp?(key) }&.last
  end

  public

  def test_list_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'speech_engines' => [{ 'speech_engine_id' => 'test-value', 'name' => 'test-value', 'voice_id' => 'test-value', 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'tags' => ['test-value'], 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }], 'next_cursor' => 'test-value', 'has_more' => true }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.speech_engine.list(page_size: 100, search: 'test-value', sort_direction: 'asc', sort_by: 'name', cursor: 'test-value')

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine', captured.uri.path)
    assert_equal(['100'], wire_test_query(captured.uri)['page_size'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['search'])
    assert_equal(['asc'], wire_test_query(captured.uri)['sort_direction'])
    assert_equal(['name'], wire_test_query(captured.uri)['sort_by'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['cursor'])
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_list_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.list(page_size: 100, search: 'test-value', sort_direction: 'asc', sort_by: 'name', cursor: 'test-value') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_create_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 201, body: { 'speech_engine_id' => 'test-value', 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 1, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true }, 'metadata' => { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'created_from' => 'cli', 'last_updated_from' => 'cli' }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.speech_engine.create(name: 'test-value', speech_engine: { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, asr: { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, tts: { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, turn: { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, vad: {}, conversation: { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, privacy: { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, call_limits: { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, auth: { 'enable_auth' => true }, language: 'test-value', cascade_timeout_seconds: 2, tags: ['test-value'], overrides: { 'first_message' => true })

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine', captured.uri.path)
    assert_equal({ 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 2, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true } }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_create_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.create(name: 'test-value', speech_engine: { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, asr: { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, tts: { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, turn: { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, vad: {}, conversation: { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, privacy: { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, call_limits: { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, auth: { 'enable_auth' => true }, language: 'test-value', cascade_timeout_seconds: 2, tags: ['test-value'], overrides: { 'first_message' => true }) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_get_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'speech_engine_id' => 'test-value', 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 1, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true }, 'metadata' => { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'created_from' => 'cli', 'last_updated_from' => 'cli' }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.speech_engine.get(speech_engine_id: 'test-value')

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine/test-value', captured.uri.path)
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_get_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.get(speech_engine_id: 'test-value') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_update_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:patch, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'speech_engine_id' => 'test-value', 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 1, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true }, 'metadata' => { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'created_from' => 'cli', 'last_updated_from' => 'cli' }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.speech_engine.update(speech_engine_id: 'test-value', name: 'test-value', speech_engine: { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, asr: { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, tts: { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, turn: { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, vad: {}, conversation: { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, privacy: { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, call_limits: { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, auth: { 'enable_auth' => true }, language: 'test-value', cascade_timeout_seconds: 2, tags: ['test-value'], overrides: { 'first_message' => true })

    refute_nil(captured)
    assert_equal('PATCH', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine/test-value', captured.uri.path)
    assert_equal({ 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 2, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true } }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_update_raises_on_422
    captured = nil
    stub_request(:patch, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.update(speech_engine_id: 'test-value', name: 'test-value', speech_engine: { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, asr: { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, tts: { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, turn: { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, vad: {}, conversation: { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, privacy: { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, call_limits: { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, auth: { 'enable_auth' => true }, language: 'test-value', cascade_timeout_seconds: 2, tags: ['test-value'], overrides: { 'first_message' => true }) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_delete_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:delete, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 204, body: nil.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    client.speech_engine.delete(speech_engine_id: 'test-value')

    refute_nil(captured)
    assert_equal('DELETE', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine/test-value', captured.uri.path)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_delete_raises_on_422
    captured = nil
    stub_request(:delete, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.delete(speech_engine_id: 'test-value') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_duplicate_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value/duplicate')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 201, body: { 'speech_engine_id' => 'test-value', 'name' => 'test-value', 'speech_engine' => { 'ws_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'asr' => { 'quality' => 'high', 'provider' => 'elevenlabs', 'user_input_audio_format' => 'pcm_8000', 'keywords' => ['test-value'] }, 'tts' => { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, 'turn' => { 'turn_timeout' => 1, 'initial_wait_time' => 1, 'silence_end_call_timeout' => 1, 'turn_eagerness' => 'patient', 'spelling_patience' => 'auto', 'speculative_turn' => true, 'retranscribe_on_turn_timeout' => true, 'turn_model' => 'turn_v2', 'interruption_ignore_terms' => ['test-value'], 'interruption_ignore_term_languages' => ['test-value'], 'merge_with_default_ignore_terms' => true, 'transcribe_on_disabled_interruptions' => true }, 'vad' => {}, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => 1, 'client_events' => ['conversation_initiation_metadata'], 'file_input' => { 'enabled' => true, 'max_files_in_memory' => 1, 'max_files_per_conversation' => 1 }, 'monitoring_enabled' => true, 'monitoring_events' => ['conversation_initiation_metadata'], 'dtmf_input_settings' => { 'dtmf_input_timeout' => 0.5, 'hash_terminator' => true, 'redact_input' => true }, 'background_sound' => { 'source_type' => 'preset', 'source_id' => 'office2', 'volume' => 0.01, 'crossfade_loop' => true }, 'source_attribution' => true }, 'privacy' => { 'record_voice' => true, 'retention_days' => 1, 'delete_transcript_and_pii' => true, 'delete_audio' => true, 'apply_to_existing_conversations' => true, 'zero_retention_mode' => true, 'conversation_history_redaction' => { 'enabled' => true, 'entities' => ['name'], 'excluded_data_collection_ids' => ['test-value'] } }, 'call_limits' => { 'agent_concurrency_limit' => 1, 'daily_limit' => 1, 'bursting_enabled' => true }, 'auth' => { 'enable_auth' => true }, 'language' => 'test-value', 'cascade_timeout_seconds' => 1, 'tags' => ['test-value'], 'overrides' => { 'first_message' => true }, 'metadata' => { 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'created_from' => 'cli', 'last_updated_from' => 'cli' }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.speech_engine.duplicate(speech_engine_id: 'test-value', name: 'test-value')

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/speech-engine/test-value/duplicate', captured.uri.path)
    assert_equal({ 'name' => 'test-value' }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_duplicate_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/speech-engine/test-value/duplicate')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.speech_engine.duplicate(speech_engine_id: 'test-value', name: 'test-value') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
