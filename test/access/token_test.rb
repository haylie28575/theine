require './test/test_helper'

class TokenTest < Minitest::Test

  def get_first_token
    VCR.use_cassette('token/get_first_token') do
      @first_token = Access::Token.search(per_page: 1).oauth_tokens.first
    end
  end

  def test_tokens_search
    VCR.use_cassette('token/search') do
      tokens_response = Access::Token.search(per_page: 1)
      assert tokens_response.success
      first_token = tokens_response.oauth_tokens.first
      assert_kind_of Access::TokenResponse, tokens_response
      assert_kind_of Access::Link, tokens_response.links
      assert_kind_of Access::Info, tokens_response.info
      assert_kind_of Array, tokens_response.oauth_tokens
      assert_kind_of Access::Token, first_token
      assert_kind_of Access::Link, first_token.links
    end
  end

  def test_tokens_find
    get_first_token
    VCR.use_cassette('token/find') do
      tokens_response = Access::Token.find(@first_token.token)
      assert tokens_response.success
      assert_kind_of Access::TokenResponse, tokens_response
      assert_kind_of Access::Token, tokens_response.oauth_token
    end
  end

end
