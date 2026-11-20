# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class VoicesWireTest < Minitest::Test
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

  def test_get_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voice_id' => 'test-value', 'name' => 'test-value', 'samples' => [{ 'sample_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'hash' => 'test-value', 'duration_secs' => 1, 'remove_background_noise' => true, 'has_isolated_audio' => true, 'has_isolated_audio_preview' => true, 'speaker_separation' => { 'voice_id' => 'test-value', 'sample_id' => 'test-value', 'status' => 'not_started', 'speakers' => { 'key' => { 'speaker_id' => 'test-value', 'duration_secs' => 1, 'utterances' => [{ 'start' => 1, 'end' => 1 }] } }, 'selected_speaker_ids' => ['test-value'] }, 'trim_start' => 1, 'trim_end' => 1 }], 'category' => 'generated', 'fine_tuning' => { 'is_allowed_to_fine_tune' => true, 'state' => { 'key' => 'not_started' }, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'manual_verification_requested' => true, 'language' => 'test-value', 'progress' => { 'key' => 1 }, 'message' => { 'key' => 'test-value' }, 'dataset_duration_seconds' => 1, 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }], 'slice_ids' => ['test-value'], 'manual_verification' => { 'extra_text' => 'test-value', 'request_time_unix' => 1, 'files' => [{ 'file_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1 }] }, 'max_verification_attempts' => 1, 'next_max_verification_attempts_reset_unix_ms' => 1, 'finetuning_state' => {} }, 'labels' => { 'key' => 'test-value' }, 'description' => 'test-value', 'preview_url' => 'test-value', 'available_for_tiers' => ['test-value'], 'settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'sharing' => { 'status' => 'enabled', 'history_item_sample_id' => 'test-value', 'date_unix' => 1, 'whitelisted_emails' => ['test-value'], 'public_owner_id' => 'test-value', 'original_voice_id' => 'test-value', 'financial_rewards_enabled' => true, 'free_users_allowed' => true, 'live_moderation_enabled' => true, 'rate' => 1, 'fiat_rate' => 1, 'notice_period' => 1, 'disable_at_unix' => 1, 'voice_mixing_allowed' => true, 'featured' => true, 'category' => 'generated', 'reader_app_enabled' => true, 'image_url' => 'test-value', 'ban_reason' => 'test-value', 'liked_by_count' => 1, 'cloned_by_count' => 1, 'name' => 'test-value', 'description' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'review_status' => 'not_requested', 'review_message' => 'test-value', 'enabled_in_library' => true, 'instagram_username' => 'test-value', 'twitter_username' => 'test-value', 'youtube_username' => 'test-value', 'tiktok_username' => 'test-value', 'moderation_check' => { 'date_checked_unix' => 1, 'name_value' => 'test-value', 'name_check' => true, 'description_value' => 'test-value', 'description_check' => true, 'sample_ids' => ['test-value'], 'sample_checks' => [1], 'captcha_ids' => ['test-value'], 'captcha_checks' => [1] }, 'reader_restricted_on' => [{ 'resource_type' => 'read', 'resource_id' => 'test-value' }] }, 'high_quality_base_model_ids' => ['test-value'], 'verified_languages' => [{ 'language' => 'test-value', 'model_id' => 'test-value', 'accent' => 'test-value', 'locale' => 'test-value', 'preview_url' => 'test-value' }], 'collection_ids' => ['test-value'], 'safety_control' => 'NONE', 'voice_verification' => { 'requires_verification' => true, 'is_verified' => true, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'language' => 'test-value', 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }] }, 'permission_on_resource' => 'test-value', 'is_owner' => true, 'is_legacy' => true, 'is_mixed' => true, 'favorited_at_unix' => 1, 'created_at_unix' => 1, 'is_bookmarked' => true, 'recording_quality' => 'studio', 'labelling_status' => 'in_review', 'recording_quality_reason' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.get(voice_id: 'test-value', with_settings: true)

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/voices/test-value', captured.uri.path)
    assert_equal(['true'], wire_test_query(captured.uri)['with_settings'])
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_get_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.get(voice_id: 'test-value', with_settings: true) }
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
    stub_request(:delete, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'status' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.delete(voice_id: 'test-value')

    refute_nil(captured)
    assert_equal('DELETE', captured.method.to_s.upcase)
    assert_equal('/v1/voices/test-value', captured.uri.path)
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_delete_raises_on_422
    captured = nil
    stub_request(:delete, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.delete(voice_id: 'test-value') }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_search_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v2/voices')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voices' => [{ 'voice_id' => 'test-value', 'name' => 'test-value', 'samples' => [{ 'sample_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'hash' => 'test-value', 'duration_secs' => 1, 'remove_background_noise' => true, 'has_isolated_audio' => true, 'has_isolated_audio_preview' => true, 'speaker_separation' => { 'voice_id' => 'test-value', 'sample_id' => 'test-value', 'status' => 'not_started', 'speakers' => { 'key' => { 'speaker_id' => 'test-value', 'duration_secs' => 1, 'utterances' => [{ 'start' => 1, 'end' => 1 }] } }, 'selected_speaker_ids' => ['test-value'] }, 'trim_start' => 1, 'trim_end' => 1 }], 'category' => 'generated', 'fine_tuning' => { 'is_allowed_to_fine_tune' => true, 'state' => { 'key' => 'not_started' }, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'manual_verification_requested' => true, 'language' => 'test-value', 'progress' => { 'key' => 1 }, 'message' => { 'key' => 'test-value' }, 'dataset_duration_seconds' => 1, 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }], 'slice_ids' => ['test-value'], 'manual_verification' => { 'extra_text' => 'test-value', 'request_time_unix' => 1, 'files' => [{ 'file_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1 }] }, 'max_verification_attempts' => 1, 'next_max_verification_attempts_reset_unix_ms' => 1, 'finetuning_state' => {} }, 'labels' => { 'key' => 'test-value' }, 'description' => 'test-value', 'preview_url' => 'test-value', 'available_for_tiers' => ['test-value'], 'settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'sharing' => { 'status' => 'enabled', 'history_item_sample_id' => 'test-value', 'date_unix' => 1, 'whitelisted_emails' => ['test-value'], 'public_owner_id' => 'test-value', 'original_voice_id' => 'test-value', 'financial_rewards_enabled' => true, 'free_users_allowed' => true, 'live_moderation_enabled' => true, 'rate' => 1, 'fiat_rate' => 1, 'notice_period' => 1, 'disable_at_unix' => 1, 'voice_mixing_allowed' => true, 'featured' => true, 'category' => 'generated', 'reader_app_enabled' => true, 'image_url' => 'test-value', 'ban_reason' => 'test-value', 'liked_by_count' => 1, 'cloned_by_count' => 1, 'name' => 'test-value', 'description' => 'test-value', 'labels' => { 'key' => 'test-value' }, 'review_status' => 'not_requested', 'review_message' => 'test-value', 'enabled_in_library' => true, 'instagram_username' => 'test-value', 'twitter_username' => 'test-value', 'youtube_username' => 'test-value', 'tiktok_username' => 'test-value', 'moderation_check' => { 'date_checked_unix' => 1, 'name_value' => 'test-value', 'name_check' => true, 'description_value' => 'test-value', 'description_check' => true, 'sample_ids' => ['test-value'], 'sample_checks' => [1], 'captcha_ids' => ['test-value'], 'captcha_checks' => [1] }, 'reader_restricted_on' => [{ 'resource_type' => 'read', 'resource_id' => 'test-value' }] }, 'high_quality_base_model_ids' => ['test-value'], 'verified_languages' => [{ 'language' => 'test-value', 'model_id' => 'test-value', 'accent' => 'test-value', 'locale' => 'test-value', 'preview_url' => 'test-value' }], 'collection_ids' => ['test-value'], 'safety_control' => 'NONE', 'voice_verification' => { 'requires_verification' => true, 'is_verified' => true, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'language' => 'test-value', 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }] }, 'permission_on_resource' => 'test-value', 'is_owner' => true, 'is_legacy' => true, 'is_mixed' => true, 'favorited_at_unix' => 1, 'created_at_unix' => 1, 'is_bookmarked' => true, 'recording_quality' => 'studio', 'labelling_status' => 'in_review', 'recording_quality_reason' => 'test-value' }], 'has_more' => true, 'total_count' => 1, 'next_page_token' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.search(next_page_token: 'test-value', page_size: 1, search: 'test-value', sort: 'test-value', sort_direction: 'test-value', voice_type: 'test-value', category: 'test-value', fine_tuning_state: 'test-value', collection_id: 'test-value', gender: 'test-value', age: 'test-value', language: ['test-value'], accent: 'test-value', use_cases: ['test-value'], min_notice_period_days: 1, include_custom_rates: true, include_live_moderated: true, high_quality: true, include_total_count: true, voice_ids: ['test-value'])

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v2/voices', captured.uri.path)
    assert_equal(['test-value'], wire_test_query(captured.uri)['next_page_token'])
    assert_equal(['1'], wire_test_query(captured.uri)['page_size'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['search'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['sort'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['sort_direction'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['voice_type'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['category'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['fine_tuning_state'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['collection_id'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['gender'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['age'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['language'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['accent'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['use_cases'])
    assert_equal(['1'], wire_test_query(captured.uri)['min_notice_period_days'])
    assert_equal(['true'], wire_test_query(captured.uri)['include_custom_rates'])
    assert_equal(['true'], wire_test_query(captured.uri)['include_live_moderated'])
    assert_equal(['true'], wire_test_query(captured.uri)['high_quality'])
    assert_equal(['true'], wire_test_query(captured.uri)['include_total_count'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['voice_ids'])
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_search_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v2/voices')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.search(next_page_token: 'test-value', page_size: 1, search: 'test-value', sort: 'test-value', sort_direction: 'test-value', voice_type: 'test-value', category: 'test-value', fine_tuning_state: 'test-value', collection_id: 'test-value', gender: 'test-value', age: 'test-value', language: ['test-value'], accent: 'test-value', use_cases: ['test-value'], min_notice_period_days: 1, include_custom_rates: true, include_live_moderated: true, high_quality: true, include_total_count: true, voice_ids: ['test-value']) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_replicate_to_isolated_environment_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value/replicate-to-isolated-environment')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voice_id' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.replicate_to_isolated_environment(voice_id: 'test-value', target_workspace_id: 'test-value', preserve_voice_id: true)

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/voices/test-value/replicate-to-isolated-environment', captured.uri.path)
    assert_equal({ 'target_workspace_id' => 'test-value', 'preserve_voice_id' => true }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_replicate_to_isolated_environment_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/test-value/replicate-to-isolated-environment')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.replicate_to_isolated_environment(voice_id: 'test-value', target_workspace_id: 'test-value', preserve_voice_id: true) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_share_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/add/test-value/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voice_id' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.share(public_user_id: 'test-value', voice_id: 'test-value', new_name: 'test-value', bookmarked: true)

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/voices/add/test-value/test-value', captured.uri.path)
    assert_equal({ 'new_name' => 'test-value', 'bookmarked' => true }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_share_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/voices/add/test-value/test-value')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.share(public_user_id: 'test-value', voice_id: 'test-value', new_name: 'test-value', bookmarked: true) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end

  def test_get_shared_sends_real_wire_request
    captured = nil
    # A `Regexp`, not a plain string: WebMock requires an EXACT URI match when the stub has no
    # query part, so a plain-string stub never matches a real request that has one (confirmed by
    # running this against a real GET with a query param -- it raised `NetConnectNotAllowedError`
    # instead of asserting anything). The query itself is asserted below via `wire_test_query`, not here.
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/shared-voices')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'voices' => [{ 'public_owner_id' => 'test-value', 'voice_id' => 'test-value', 'date_unix' => 1, 'name' => 'test-value', 'accent' => 'test-value', 'gender' => 'test-value', 'age' => 'test-value', 'descriptive' => 'test-value', 'use_case' => 'test-value', 'category' => 'generated', 'language' => 'test-value', 'locale' => 'test-value', 'description' => 'test-value', 'preview_url' => 'test-value', 'usage_character_count_1y' => 1, 'usage_character_count_7d' => 1, 'play_api_usage_character_count_1y' => 1, 'cloned_by_count' => 1, 'rate' => 1, 'fiat_rate' => 1, 'free_users_allowed' => true, 'live_moderation_enabled' => true, 'featured' => true, 'verified_languages' => [{ 'language' => 'test-value', 'model_id' => 'test-value', 'accent' => 'test-value', 'locale' => 'test-value', 'preview_url' => 'test-value' }], 'notice_period' => 1, 'instagram_username' => 'test-value', 'twitter_username' => 'test-value', 'youtube_username' => 'test-value', 'tiktok_username' => 'test-value', 'image_url' => 'test-value', 'is_added_by_user' => true, 'is_bookmarked' => true }], 'has_more' => true, 'total_count' => 1, 'last_sort_id' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.voices.get_shared(page_size: 1, category: 'professional', gender: 'test-value', age: 'test-value', accent: 'test-value', language: 'test-value', locale: 'test-value', search: 'test-value', use_cases: ['test-value'], descriptives: ['test-value'], featured: true, min_notice_period_days: 1, include_custom_rates: true, include_live_moderated: true, reader_app_enabled: true, owner_id: 'test-value', sort: 'created_date', page: 1)

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/shared-voices', captured.uri.path)
    assert_equal(['1'], wire_test_query(captured.uri)['page_size'])
    assert_equal(['professional'], wire_test_query(captured.uri)['category'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['gender'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['age'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['accent'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['language'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['locale'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['search'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['use_cases'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['descriptives'])
    assert_equal(['true'], wire_test_query(captured.uri)['featured'])
    assert_equal(['1'], wire_test_query(captured.uri)['min_notice_period_days'])
    assert_equal(['true'], wire_test_query(captured.uri)['include_custom_rates'])
    assert_equal(['true'], wire_test_query(captured.uri)['include_live_moderated'])
    assert_equal(['true'], wire_test_query(captured.uri)['reader_app_enabled'])
    assert_equal(['test-value'], wire_test_query(captured.uri)['owner_id'])
    assert_equal(['created_date'], wire_test_query(captured.uri)['sort'])
    assert_equal(['1'], wire_test_query(captured.uri)['page'])
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_get_shared_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/shared-voices')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.voices.get_shared(page_size: 1, category: 'professional', gender: 'test-value', age: 'test-value', accent: 'test-value', language: 'test-value', locale: 'test-value', search: 'test-value', use_cases: ['test-value'], descriptives: ['test-value'], featured: true, min_notice_period_days: 1, include_custom_rates: true, include_live_moderated: true, reader_app_enabled: true, owner_id: 'test-value', sort: 'created_date', page: 1) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
