require './test/test_helper'

class VerifyTest < Minitest::Test

  def test_verify_token
    VCR.use_cassette('verify/token') do
      verify_response = Access::Verify.token
      assert verify_response.success
      assert_kind_of Access::VerifyResponse, verify_response
      assert_kind_of Access::Verify, verify_response.oauth_access_token
    end
  end

  def test_verify_filter
    VCR.use_cassette('verify/filter') do
      single_filter = '{"program_filter": {"offers": [{"or":[{"terms":{"categories.category_key":[ 39, 1007, 1008, 1009, 1010, 1011, 1012 ] } }, {"terms":{"categories.category_parent_key":[ 39, 1007, 1008, 1009, 1010, 1011, 1012]} } ]}, {"not": {"or": [{"terms":{"categories.category_key":[ 1007 ] } }, {"terms":{"categories.category_parent_key":[ 1007 ] } } ] } } ] } }'
      verify_response = Access::Verify.filter single_filter
      assert verify_response.success
      assert_kind_of Access::VerifyResponse, verify_response
      assert_kind_of Access::Verify, verify_response.categories
      assert_kind_of Access::Verify, verify_response.locations
      assert_kind_of Access::Verify, verify_response.stores
      assert_kind_of Access::Verify, verify_response.offers
      assert_kind_of Access::Redeem, verify_response.offers.redemption_methods.first
      assert_kind_of Access::Category, verify_response.offers.categories.first
    end
  end

end
