# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class TextToSpeechWireTest < Minitest::Test
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

  def test_convert_with_timestamps_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-speech/test-value/with-timestamps')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'audio_base64' => 'test-value', 'alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }, 'normalized_alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.text_to_speech.convert_with_timestamps(voice_id: 'test-value', enable_logging: true, optimize_streaming_latency: 1, output_format: 'alaw_8000', text: 'test-value', model_id: 'test-value', language_code: 'test-value', voice_settings: { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, pronunciation_dictionary_locators: [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], seed: 1, previous_text: 'test-value', next_text: 'test-value', previous_request_ids: ['test-value'], next_request_ids: ['test-value'], use_pvc_as_ivc: true, apply_text_normalization: 'auto', apply_language_text_normalization: true, audio_effects: { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 })

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/text-to-speech/test-value/with-timestamps', captured.uri.path)
    assert_equal(['true'], wire_test_query(captured.uri)['enable_logging'])
    assert_equal(['1'], wire_test_query(captured.uri)['optimize_streaming_latency'])
    assert_equal(['alaw_8000'], wire_test_query(captured.uri)['output_format'])
    assert_equal({ 'text' => 'test-value', 'model_id' => 'test-value', 'language_code' => 'test-value', 'voice_settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'seed' => 1, 'previous_text' => 'test-value', 'next_text' => 'test-value', 'previous_request_ids' => ['test-value'], 'next_request_ids' => ['test-value'], 'use_pvc_as_ivc' => true, 'apply_text_normalization' => 'auto', 'apply_language_text_normalization' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_convert_with_timestamps_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-speech/test-value/with-timestamps')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.text_to_speech.convert_with_timestamps(voice_id: 'test-value', enable_logging: true, optimize_streaming_latency: 1, output_format: 'alaw_8000', text: 'test-value', model_id: 'test-value', language_code: 'test-value', voice_settings: { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, pronunciation_dictionary_locators: [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], seed: 1, previous_text: 'test-value', next_text: 'test-value', previous_request_ids: ['test-value'], next_request_ids: ['test-value'], use_pvc_as_ivc: true, apply_text_normalization: 'auto', apply_language_text_normalization: true, audio_effects: { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 }) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_stream_with_timestamps_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-speech/test-value/stream/with-timestamps')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'audio_base64' => 'test-value', 'alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }, 'normalized_alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] } }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.text_to_speech.stream_with_timestamps(voice_id: 'test-value', enable_logging: true, optimize_streaming_latency: 1, output_format: 'mp3_22050_32', text: 'test-value', model_id: 'test-value', language_code: 'test-value', voice_settings: { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, pronunciation_dictionary_locators: [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], seed: 1, previous_text: 'test-value', next_text: 'test-value', previous_request_ids: ['test-value'], next_request_ids: ['test-value'], use_pvc_as_ivc: true, apply_text_normalization: 'auto', apply_language_text_normalization: true, audio_effects: { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 })
    # Streaming methods return a lazy Enumerator; consuming it is what sends the request.
    result.to_a

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/text-to-speech/test-value/stream/with-timestamps', captured.uri.path)
    assert_equal(['true'], wire_test_query(captured.uri)['enable_logging'])
    assert_equal(['1'], wire_test_query(captured.uri)['optimize_streaming_latency'])
    assert_equal(['mp3_22050_32'], wire_test_query(captured.uri)['output_format'])
    assert_equal({ 'text' => 'test-value', 'model_id' => 'test-value', 'language_code' => 'test-value', 'voice_settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'seed' => 1, 'previous_text' => 'test-value', 'next_text' => 'test-value', 'previous_request_ids' => ['test-value'], 'next_request_ids' => ['test-value'], 'use_pvc_as_ivc' => true, 'apply_text_normalization' => 'auto', 'apply_language_text_normalization' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_stream_with_timestamps_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-speech/test-value/stream/with-timestamps')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.text_to_speech.stream_with_timestamps(voice_id: 'test-value', enable_logging: true, optimize_streaming_latency: 1, output_format: 'mp3_22050_32', text: 'test-value', model_id: 'test-value', language_code: 'test-value', voice_settings: { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, pronunciation_dictionary_locators: [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], seed: 1, previous_text: 'test-value', next_text: 'test-value', previous_request_ids: ['test-value'], next_request_ids: ['test-value'], use_pvc_as_ivc: true, apply_text_normalization: 'auto', apply_language_text_normalization: true, audio_effects: { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 }).to_a }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
