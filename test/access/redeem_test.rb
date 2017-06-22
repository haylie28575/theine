require './test/test_helper'

class RedeemTest < Minitest::Test

  def get_first_offer
    VCR.use_cassette('offer/search_for_redeem') do
      @first_offer = Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST', per_page: 1).offers.first
    end
  end

  def test_redeem_offer_no_redeem_type
    get_first_offer
    VCR.use_cassette('redeem/offer_no_redeem_type') do
      redeem_response = Access::Redeem.redeem_offer(@first_offer.offer_key, nil, member_key: 'API_RUBY_GEM_TEST')
      assert redeem_response.success
      assert_kind_of Access::RedeemResponse, redeem_response
      assert_kind_of Array, redeem_response.links
      assert_kind_of Access::Link, redeem_response.links.first
      assert redeem_response.links.first.href
      assert redeem_response.links.first.rel
    end
  end


  def test_redeem_offer_with_redeem_type
    get_first_offer
    VCR.use_cassette('redeem/offer_with_redeem_type') do
      redeem_response = Access::Redeem.redeem_offer(@first_offer.offer_key, @first_offer.redemption_methods.first, member_key: 'API_RUBY_GEM_TEST')
      assert redeem_response.success
      assert_kind_of Access::RedeemResponse, redeem_response
      assert_kind_of Array, redeem_response.links
      assert redeem_response.content_type
      assert redeem_response.redemption_method
      assert redeem_response.details
      assert redeem_response.details.link
    end
  end
end
