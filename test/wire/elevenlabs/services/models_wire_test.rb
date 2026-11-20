# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class ModelsWireTest < Minitest::Test
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
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/models')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: [{ 'model_id' => 'test-value', 'name' => 'test-value', 'can_be_finetuned' => true, 'can_do_text_to_speech' => true, 'can_do_voice_conversion' => true, 'can_use_style' => true, 'can_use_speaker_boost' => true, 'serves_pro_voices' => true, 'token_cost_factor' => 1, 'description' => 'test-value', 'requires_alpha_access' => true, 'max_characters_request_free_user' => 1, 'max_characters_request_subscribed_user' => 1, 'maximum_text_length_per_request' => 1, 'languages' => [{ 'language_id' => 'test-value', 'name' => 'test-value' }], 'model_rates' => { 'character_cost_multiplier' => 1, 'cost_discount_multiplier' => 1 }, 'concurrency_group' => 'test-value' }].to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.models.list

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/models', captured.uri.path)
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_list_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/models')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.models.list }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
