require './test/test_helper'

class OfferTest < Minitest::Test

  def get_first_offer
    VCR.use_cassette('offer/search_first') do
      @first_offer = Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST', per_page: 1).offers.first
    end
  end

  def test_offers_search
    assert_equal Access.config.access_token, ENV['ACCESS_TOKEN']

    VCR.use_cassette('offer/search') do
      offers_response = Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      first_offer = offers_response.offers.first
      assert offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Access::Link, offers_response.links
      assert_kind_of Access::Info, offers_response.info
      assert_kind_of Array, offers_response.offers
      assert_kind_of Access::Offer, first_offer
      assert_kind_of Access::Category, first_offer.categories.first
      assert_kind_of Access::Store, first_offer.offer_store
      assert_kind_of Access::Location, first_offer.location
       assert_kind_of Access::Geolocation, first_offer.location.geolocation
      assert_kind_of Access::Link, first_offer.links
    end
  end

  def test_offers_find
    get_first_offer
    VCR.use_cassette('offer/find') do
      offers_response = Access::Offer.find(@first_offer.offer_key, query: 'pizza', member_key: 'API_RUBY_GEM_TEST')
      first_offer = offers_response.offers.first
      assert offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Access::Offer, first_offer
    end
  end

  def test_offers_extra_methods
    VCR.use_cassette('offer/search') do
      offers_response = Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      first_offer = offers_response.offers.first
      assert offers_response.success
      assert_equal first_offer.offer_store.physical_location, first_offer.location
      assert_equal first_offer.offer_store, first_offer.store
    end
  end

  def test_offers_fail_member_key
    VCR.use_cassette('offer/search_fail_member_key') do
      offers_response = Access::Offer.search(query: 'pizza')
      refute offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Access::Error, offers_response.error
      assert_equal 401,  offers_response.error.status_code
      assert_equal "Must include a member_key to see details.",  offers_response.error.message
      assert_equal "Unauthorized",  offers_response.error.status
    end
  end

  def test_offers_fail_no_access_token
    orginal_token = ENV['ACCESS_TOKEN']
    Access.config.access_token = ENV['ACCESS_TOKEN'] = nil
    assert_raises(Access::Error::NoAccessToken) { Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST') }
    Access.config.access_token = ENV['ACCESS_TOKEN'] = orginal_token
  end

  def test_offers_with_aggregation
    VCR.use_cassette('offer/with_aggregations') do
      offers_response = Access::Offer.search(query: 'pizza', member_key: 'API_RUBY_GEM_TEST', aggregations: 'all_categories,stores,locations,redemption_methods')
      assert offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Array, offers_response.offer_count_in_categories
      assert_kind_of Access::Aggregations, offers_response.offer_count_in_categories.first
      assert offers_response.offer_count_in_categories.first.category_name
      assert_kind_of Array, offers_response.offer_count_in_categories.first.subcategories
      assert_kind_of Access::Category, offers_response.offer_count_in_categories.first.subcategories.first
      assert_kind_of Array, offers_response.offer_count_by_redemption_method
      assert_kind_of Access::Aggregations, offers_response.offer_count_by_redemption_method.first
      assert offers_response.offer_count_by_redemption_method.first.offer_count
      assert offers_response.offer_count_by_redemption_method.first.redemption_method
      assert offers_response.info.total_locations
      assert offers_response.info.total_stores
    end
  end

  def test_offers_find_with_offer_uses_remaining
    get_first_offer
    VCR.use_cassette('offer/find_with_offer_uses_remaining') do
      offers_response = Access::Offer.find(@first_offer.offer_key, query: 'pizza', member_key: 'API_RUBY_GEM_TEST', uses_remaining: 'true')
      first_offer = offers_response.offers.first
      assert offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Access::Offer, first_offer
      assert_kind_of Access::Redemption, first_offer.offer_uses_remaining
    end
  end

  def test_offer_uses_remaining
    get_first_offer
    VCR.use_cassette('redeem/redeem_offer_with_redeem_type_for_uses_remaining_test') do
      Access::Redeem.redeem_offer(@first_offer.offer_key, @first_offer.redemption_methods.first, member_key: 'API_RUBY_GEM_TEST')
    end
    VCR.use_cassette('offer/find_uses_remaining') do
      offers_response = Access::Offer.find_uses_remaining(@first_offer.offer_key, member_key: 'API_RUBY_GEM_TEST')
      first_offer = offers_response.offers.first
      assert offers_response.success
      assert_kind_of Access::OfferResponse, offers_response
      assert_kind_of Access::Offer, first_offer
      assert_kind_of Access::Redemption, first_offer.offer_uses_remaining
      assert_equal @first_offer.offer_key, first_offer.offer_uses_remaining.offer_key
      assert first_offer.offer_uses_remaining.uses_this_period
    end
  end
end
