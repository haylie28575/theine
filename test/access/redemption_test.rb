require './test/test_helper'

class RedemptionTest < Minitest::Test

  def get_first_redemption
    VCR.use_cassette('redemption/search_by_member_key_first') do
      @first_redemption = Access::Redemption.search_by_member('API_RUBY_GEM_TEST').offer_redemptions.first
    end
  end

  def test_search_offer_redemptions_by_member
    VCR.use_cassette('redemption/search_by_member_key') do
      redemption_response = Access::Redemption.search_by_member('API_RUBY_GEM_TEST')
      assert redemption_response.success
      assert_kind_of Access::RedemptionResponse, redemption_response
      assert_kind_of Access::Offer, redemption_response.offer_redemptions.first.offer
      assert_kind_of Access::Member, redemption_response.offer_redemptions.first.member
    end
  end

  def test_find_offer_redemptions_by_member
    get_first_redemption
    VCR.use_cassette('redemption/find_by_member_key') do
      redemption_response = Access::Redemption.find_by_member('API_RUBY_GEM_TEST', @first_redemption.usage_redeem_key)
      assert redemption_response.success
      assert_kind_of Access::RedemptionResponse, redemption_response
      assert_kind_of Access::Offer, redemption_response.offer_redemptions.first.offer
      assert_kind_of Access::Member, redemption_response.offer_redemptions.first.member
    end
  end

  def test_search_offer_redemptions_by_member_with_no_redemptions
    VCR.use_cassette('redemption/search_by_member_key_without_redemptions') do
      redemption_response = Access::Redemption.search_by_member('API_RUBY_GEM_TEST_NOREDEMPTIONS')
      refute redemption_response.success
      assert_kind_of Access::RedemptionResponse, redemption_response
      assert_kind_of Access::Error, redemption_response.error
      assert_equal 200, redemption_response.error.status_code
      assert_equal "No redemptions found.", redemption_response.error.message
    end
  end
end
