require './test/test_helper'

class OauthApplicationTest < Minitest::Test

  def get_first_oauth_application
    VCR.use_cassette('oauth_application/search_oauth_first') do
      @first_oauth_application = Access::OauthApplication.search(per_page: 1).oauth_applications.first
    end
  end

  def get_first_access_token
    get_first_oauth_application
    VCR.use_cassette('oauth_application/token_search_tokens_first') do
      @first_access_token = Access::OauthApplication.search_tokens(@first_oauth_application.id, per_page: 1).access_tokens.first
    end
  end

  def test_oauth_applications_search
    VCR.use_cassette('oauth_application/search') do
      oauth_applications_response = Access::OauthApplication.search(per_page: 1)
      assert oauth_applications_response.success
      first_oauth_application = oauth_applications_response.oauth_applications.first
      assert_kind_of Access::OauthApplicationResponse, oauth_applications_response
      assert_kind_of Access::Link, oauth_applications_response.links
      assert_kind_of Access::Info, oauth_applications_response.info
      assert_kind_of Array, oauth_applications_response.oauth_applications
      assert_equal 1, oauth_applications_response.oauth_applications.count
      assert_kind_of Access::OauthApplication, first_oauth_application
      assert_kind_of Access::Link, first_oauth_application.links
      assert_kind_of Access::Filter, first_oauth_application.filter
      # has scope? method
    end
  end

  def test_oauth_applications_find
    get_first_oauth_application
    VCR.use_cassette('oauth_application/find') do
      oauth_applications_response = Access::OauthApplication.find(@first_oauth_application.id)
      assert oauth_applications_response.success
      first_oauth_application = oauth_applications_response.oauth_applications.first
      assert_kind_of Access::OauthApplicationResponse, oauth_applications_response
      assert_kind_of Access::OauthApplication, first_oauth_application
      assert_kind_of Access::Filter, first_oauth_application.filter
    end
  end

  def test_oauth_applications_search_tokens
    get_first_oauth_application
    VCR.use_cassette('oauth_application/token_search') do
      access_tokens_response = Access::OauthApplication.search_tokens(@first_oauth_application.id, per_page: 1)
      assert access_tokens_response.success
      first_access_token = access_tokens_response.access_tokens.first
      assert_kind_of Access::TokenResponse, access_tokens_response
      assert_kind_of Array, access_tokens_response.access_tokens
      assert_kind_of Access::Link, first_access_token.links
      refute_kind_of Hash, first_access_token.program_filter_id
      # has scope? method
    end
  end

  def test_oauth_applications_find_token
    get_first_access_token
    VCR.use_cassette('oauth_application/token_find') do
      access_tokens_response = Access::OauthApplication.find_token(@first_access_token.application_id, @first_access_token.oauth_access_token_id)
      assert access_tokens_response.success
      first_access_token = access_tokens_response.access_tokens.first
      assert_kind_of Access::TokenResponse, access_tokens_response
      assert_kind_of Array, access_tokens_response.access_tokens
      assert_equal 1, access_tokens_response.access_tokens.count
      refute_kind_of Hash, first_access_token.program_filter_id
      # has scope? method
    end
  end

  def test_oauth_applications_create_token
    skip
  end

  def test_oauth_applications_create
    skip
  end

  def test_oauth_applications_update
    skip
  end

  def test_oauth_applications_delete
    skip
  end
end
