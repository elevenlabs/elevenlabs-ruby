# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class TextToVoiceWireTest < Minitest::Test
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

  def test_create_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voice_id' => 'test-value', 'name' => 'test-value', 'samples' => [{ 'sample_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'hash' => 'test-value', 'duration_secs' => 1, 'remove_background_noise' => true, 'has_isolated_audio' => true, 'has_isolated_audio_preview' => true, 'speaker_separation' => { 'voice_id' => 'test-value', 'sample_id' => 'test-value', 'status' => 'not_started', 'speakers' => { 'key' => { 'speaker_id' => 'test-value', 'duration_secs' => 1, 'utterances' => [{ 'start' => 1, 'end' => 1 }] } }, 'selected_speaker_ids' => ['test-value'] }, 'trim_start' => 1, 'trim_end' => 1 }], 'category' => 'generated', 'fine_tuning' => { 'is_allowed_to_fine_tune' => true, 'state' => { 'key' => 'not_started' }, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'manual_verification_requested' => true, 'language' => 'test-value', 'progress' => { 'key' => 1 }, 'message' => { 'key' => 'test-value' }, 'dataset_duration_seconds' => 1, 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }], 'slice_ids' => ['test-value'], 'manual_verification' => { 'extra_text' => 'test-value', 'request_time_unix' => 1, 'files' => [{ 'file_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1 }] }, 'max_verification_attempts' => 1, 'next_max_verification_attempts_reset_unix_ms' => 1, 'finetuning_state' => {} }, 'labels' => { 'key' => 'test-value' }, 'description' => 'test-value', 'preview_url' => 'test-value', 'available_for_tiers' => ['test-value'], 'settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'sharing' => { 'status' => 'enabled', 'history_item_sample_id' => 'test-value', 'date_unix' => 1, 'whitelisted_emails' => ['test-value'], 'public_owner_id' => 'test-value', 'original_voice_id' => 'test-value', 'financial_rewards_enabled' => true, 'free_users_allowed' => true, 'live_moderation_enabled' => true, 'rate' => 1, 'fiat_rate' => 1, 'notice_period' => 1, 'disable_at_unix' => 1, 'voice_mixing_allowed' => true, 'featured' => true, 'category' => 'generated', 'reader_app_enabled' => true, 'image_url' => 'test-value', 'ban_reason' => 'test-value', 'liked_by_count' => 1, 'cloned_by_count' => 1, 'name' => 'test-value', 'description' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'review_status' => 'not_requested', 'review_message' => 'test-value', 'enabled_in_library' => true, 'instagram_username' => 'test-value', 'twitter_username' => 'test-value', 'youtube_username' => 'test-value', 'tiktok_username' => 'test-value', 'moderation_check' => { 'date_checked_unix' => 1, 'name_value' => 'test-value', 'name_check' => true, 'description_value' => 'test-value', 'description_check' => true, 'sample_ids' => ['test-value'], 'sample_checks' => [1], 'captcha_ids' => ['test-value'], 'captcha_checks' => [1] }, 'reader_restricted_on' => [{ 'resource_type' => 'read', 'resource_id' => 'test-value' }] }, 'high_quality_base_model_ids' => ['test-value'], 'verified_languages' => [{ 'language' => 'test-value', 'model_id' => 'test-value', 'accent' => 'test-value', 'locale' => 'test-value', 'preview_url' => 'test-value' }], 'collection_ids' => ['test-value'], 'safety_control' => 'NONE', 'voice_verification' => { 'requires_verification' => true, 'is_verified' => true, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'language' => 'test-value', 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }] }, 'permission_on_resource' => 'test-value', 'is_owner' => true, 'is_legacy' => true, 'is_mixed' => true, 'favorited_at_unix' => 1, 'created_at_unix' => 1, 'is_bookmarked' => true, 'recording_quality' => 'studio', 'labelling_status' => 'in_review', 'recording_quality_reason' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.text_to_voice.create(voice_name: 'test-value', voice_description: 'test-valuetest-value', generated_voice_id: 'test-value', labels: { 'key' => 'test-value' }, played_not_selected_voice_ids: ['test-value'])

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/text-to-voice', captured.uri.path)
    assert_equal({ 'voice_name' => 'test-value', 'voice_description' => 'test-valuetest-value', 'generated_voice_id' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'played_not_selected_voice_ids' => ['test-value'] }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_create_raises_on_409
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 409, body: nil.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::ConflictError) { client.text_to_voice.create(voice_name: 'test-value', voice_description: 'test-valuetest-value', generated_voice_id: 'test-value', labels: { 'key' => 'test-value' }, played_not_selected_voice_ids: ['test-value']) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_design_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice/design')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'previews' => [{ 'audio_base_64' => 'test-value', 'generated_voice_id' => 'test-value', 'media_type' => 'test-value', 'duration_secs' => 1, 'language' => 'test-value' }], 'text' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.text_to_voice.design(output_format: 'mp3_22050_32', voice_description: 'test-valuetest-value', model_id: 'eleven_multilingual_ttv_v2', text: 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', auto_generate_text: true, loudness: -1, seed: 0, guidance_scale: 0, stream_previews: true, should_enhance: true, remixing_session_id: 'test-value', remixing_session_iteration_id: 'test-value', quality: -1, reference_audio_base64: 'test-value', prompt_strength: 0)

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/text-to-voice/design', captured.uri.path)
    assert_equal(['mp3_22050_32'], wire_test_query(captured.uri)['output_format'])
    assert_equal({ 'voice_description' => 'test-valuetest-value', 'model_id' => 'eleven_multilingual_ttv_v2', 'text' => 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', 'auto_generate_text' => true, 'loudness' => -1, 'seed' => 0, 'guidance_scale' => 0, 'stream_previews' => true, 'should_enhance' => true, 'remixing_session_id' => 'test-value', 'remixing_session_iteration_id' => 'test-value', 'quality' => -1, 'reference_audio_base64' => 'test-value', 'prompt_strength' => 0 }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_design_raises_on_409
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice/design')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 409, body: nil.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::ConflictError) { client.text_to_voice.design(output_format: 'mp3_22050_32', voice_description: 'test-valuetest-value', model_id: 'eleven_multilingual_ttv_v2', text: 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', auto_generate_text: true, loudness: -1, seed: 0, guidance_scale: 0, stream_previews: true, should_enhance: true, remixing_session_id: 'test-value', remixing_session_iteration_id: 'test-value', quality: -1, reference_audio_base64: 'test-value', prompt_strength: 0) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_remix_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice/test-value/remix')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'previews' => [{ 'audio_base_64' => 'test-value', 'generated_voice_id' => 'test-value', 'media_type' => 'test-value', 'duration_secs' => 1, 'language' => 'test-value' }], 'text' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.text_to_voice.remix(voice_id: 'test-value', output_format: 'mp3_22050_32', voice_description: 'test-value', text: 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', auto_generate_text: true, loudness: -1, seed: 0, guidance_scale: 0, stream_previews: true, remixing_session_id: 'test-value', remixing_session_iteration_id: 'test-value', prompt_strength: 0)

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/text-to-voice/test-value/remix', captured.uri.path)
    assert_equal(['mp3_22050_32'], wire_test_query(captured.uri)['output_format'])
    assert_equal({ 'voice_description' => 'test-value', 'text' => 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', 'auto_generate_text' => true, 'loudness' => -1, 'seed' => 0, 'guidance_scale' => 0, 'stream_previews' => true, 'remixing_session_id' => 'test-value', 'remixing_session_iteration_id' => 'test-value', 'prompt_strength' => 0 }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_remix_raises_on_409
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/text-to-voice/test-value/remix')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 409, body: nil.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::ConflictError) { client.text_to_voice.remix(voice_id: 'test-value', output_format: 'mp3_22050_32', voice_description: 'test-value', text: 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', auto_generate_text: true, loudness: -1, seed: 0, guidance_scale: 0, stream_previews: true, remixing_session_id: 'test-value', remixing_session_iteration_id: 'test-value', prompt_strength: 0) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
