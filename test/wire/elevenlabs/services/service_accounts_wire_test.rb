# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'
require 'webmock/minitest'
require 'uri'

class ServiceAccountsWireTest < Minitest::Test
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
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/service-accounts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'service-accounts' => [{ 'service_account_user_id' => 'test-value', 'name' => 'test-value', 'created_at_unix' => 1, 'api-keys' => [{ 'name' => 'test-value', 'hint' => 'test-value', 'key_id' => 'test-value', 'service_account_user_id' => 'test-value', 'created_at_unix' => 1, 'is_disabled' => true, 'permissions' => ['text_to_speech'], 'disable_reason' => 'trial_ended', 'character_limit' => 1, 'character_count' => 1, 'hashed_xi_api_key' => 'test-value', 'allowed_ips' => ['test-value'], 'third_party_disable_allowed' => true, 'platform_limits' => { 'credits' => { 'limit' => 1, 'usage' => 1 }, 'pvc' => { 'limit' => 1 }, 'concurrency' => { 'limit' => 1 }, 'dubbing_concurrency' => { 'limit' => 1 }, 'music_concurrency' => { 'limit' => 1 } }, 'expires_at_unix' => 1 }], 'default_sharing_groups' => [{ 'group' => { 'name' => 'test-value', 'id' => 'test-value', 'members' => ['test-value'], 'permissions' => ['text_to_speech'], 'group_usage_limit' => 1, 'group_pvc_limit' => 1, 'group_concurrency_limit' => 1, 'group_dubbing_concurrency_limit' => 1, 'group_music_concurrency_limit' => 1, 'character_count' => 1, 'is_scim_synced' => true, 'scim_group' => { 'scim_external_id' => 'test-value', 'display_name' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'seat_type' => 'workspace_admin' }, 'scim_frozen' => true }, 'permission_level' => 'admin' }] }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.service_accounts.list

    refute_nil(captured)
    assert_equal('GET', captured.method.to_s.upcase)
    assert_equal('/v1/service-accounts', captured.uri.path)
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_list_raises_on_422
    captured = nil
    stub_request(:get, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/service-accounts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.service_accounts.list }
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
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/service-accounts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 200, body: { 'service-account-user-id' => 'test-value' }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    result = client.service_accounts.create(name: 'test-value', default_sharing_groups: [{ 'group_id' => 'test-value', 'permission_level' => 'admin' }])

    refute_nil(captured)
    assert_equal('POST', captured.method.to_s.upcase)
    assert_equal('/v1/service-accounts', captured.uri.path)
    assert_equal({ 'name' => 'test-value', 'default_sharing_groups' => [{ 'group_id' => 'test-value', 'permission_level' => 'admin' }] }, JSON.parse(captured.body))
    refute_nil(result)
  end

  # `method.errorCase` is only ever set when the SDK actually raises a typed class for this
  # status -- fernMode raises for any declared 4xx/5xx (see `fernErrorClassNameForStatus`'s doc
  # comment in `wire-test-service-data.ts`), but legacy only raises a TYPED error when that status
  # declares a JSON body backed by a model; anything else is skipped rather than guessed.
  def test_create_raises_on_422
    captured = nil
    stub_request(:post, %r{\A#{Regexp.escape(BASE_URL)}#{Regexp.escape('/v1/service-accounts')}(\?|\z)}).to_return do |request|
      captured = request
      { status: 422, body: { 'detail' => [{ 'loc' => ['test-value'], 'msg' => 'test-value', 'type' => 'test-value' }] }.to_json, headers: { 'Content-Type' => 'application/json' } }
    end

    client = ::Elevenlabs::Client.new(base_url: BASE_URL)
    assert_raises(::Elevenlabs::Errors::UnprocessableEntityError) { client.service_accounts.create(name: 'test-value', default_sharing_groups: [{ 'group_id' => 'test-value', 'permission_level' => 'admin' }]) }
    # `assert_raises` only proves the right CLASS was raised, not that the mocked endpoint was
    # ever hit -- a bug that raises before the HTTP call (e.g. argument validation) would satisfy
    # it just as well. This is the same proof every other test in this file already requires.
    refute_nil(captured)
  end
end
