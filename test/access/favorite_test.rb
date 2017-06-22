require './test/test_helper'

class FavoriteTest < Minitest::Test

  def setup_favorites
    VCR.use_cassette('favorite/one_of_everything') do
      @offer = Access::Offer.search(member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'], query: '_exists_:program_keys', all_offers: 'true').offers.first
      # make sure there is a member that exists first
      Access::Redeem.redeem_offer(@offer.offer_key, @offer.redemption_methods.first, member_key: "API_TEST", access_timeout: 10, access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'], first_name: 'q', last_name: 'a')
      # make sure there is an offer favorited first
      Access::Favorite.create_offer @offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      Access::Favorite.create_location @offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      Access::Favorite.create_store @offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
    end
    @offer
  end

  def setup
    @@offer ||= setup_favorites
  end

  def test_favorite_search
    VCR.use_cassette('favorite/search') do
      request = Access::Favorite.search member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert request.success
      assert_kind_of Access::FavoriteResponse, request
      assert_kind_of Array, request.favorites
      assert request.favorites.map(&:favorite_type).uniq.count > 1, 'it should have more than one favorite type (offers/stores/locations)'
      assert_kind_of Access::Favorite, request.favorites.first
    end
  end

  def test_favorite_resource_links_to_the_object
    favorite = Access::Favorite.new favorite_type: 'location', favorited_date: Time.now, location: {location_key: 123}
    assert_equal favorite.resource, favorite.location
  end

  def test_favorite_search_with_bad_member
    VCR.use_cassette('favorite/search_bad_member') do
      request = Access::Favorite.search member_key: 'API_TEST_FAVORITE_BAD_MEMBER', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      refute request.success
      assert_kind_of Access::FavoriteResponse, request
      assert_empty request.favorites
    end
  end

  def test_favorite_search_with_no_favorites
    # TODO refactor after fav api update
    VCR.use_cassette('favorite/search_no_favorites') do
      request = Access::Favorite.search member_key: 'API_TEST_FAVORITE_NO_FAVORITES', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      refute request.success
      assert_kind_of Access::FavoriteResponse, request
      assert_empty request.favorites
    end
  end

  def test_favorite_search_offers
    VCR.use_cassette('favorite/search_offers') do
      request = Access::Favorite.search_offers member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_offer_response(request)
    end
  end

  def test_favorite_search_locations
    VCR.use_cassette('favorite/search_locations') do
      request = Access::Favorite.search_locations member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_location_response(request)
    end
  end

  def test_favorite_search_stores
    VCR.use_cassette('favorite/search_stores') do
      request = Access::Favorite.search_stores member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_store_response(request)
    end
  end

  def test_favorite_find
    VCR.use_cassette('favorite/find_generic_with_offer') do
      Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      request = Access::Favorite.find @@offer.offer_key, favorite_type: 'offers', member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_offer_response(request)
    end
  end

  def test_favorite_find_offer
    VCR.use_cassette('favorite/find_offer') do
      Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      request = Access::Favorite.find_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_offer_response(request)
    end
  end

  def test_favorite_find_location
    VCR.use_cassette('favorite/find_location') do
      Access::Favorite.create_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      request = Access::Favorite.find_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_location_response(request)
    end
  end

  def test_favorite_find_store
    VCR.use_cassette('favorite/find_store') do

      Access::Favorite.create_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      request = Access::Favorite.find_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_store_response(request)
    end
  end

  def test_favorite_create
    VCR.use_cassette('favorite/create_generic_with_offer') do
      request = Access::Favorite.create @@offer.offer_key, favorite_type: 'offers', member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_offer_response(request)
    end
  end

  def test_favorite_create_offer
    VCR.use_cassette('favorite/create_offer') do
      request = Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_offer_response(request)
    end
  end


  def test_favorite_create_location
    VCR.use_cassette('favorite/create_location') do
      request = Access::Favorite.create_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_location_response(request)
    end
  end

  def test_favorite_create_store
    VCR.use_cassette('favorite/create_store') do
      request = Access::Favorite.create_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert_good_favorite_store_response(request)
    end
  end

  def test_favorite_delete
    VCR.use_cassette('favorite/delete_generic_with_offer') do
      request = Access::Favorite.delete @@offer.offer_key, favorite_type: 'offers', member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert request.success
      assert_kind_of Access::FavoriteResponse, request
      # remake it after
      Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
    end
  end

  def test_favorite_delete_offer
    VCR.use_cassette('favorite/delete_offer') do
      Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'] # create it first, in case it was deleted
      request = Access::Favorite.delete_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert request.success
      assert_kind_of Access::FavoriteResponse, request
      Access::Favorite.create_offer @@offer.offer_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
    end
  end

  def test_favorite_delete_location
    VCR.use_cassette('favorite/delete_location') do
      Access::Favorite.delete_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'] # create it first, in case it was deleted
      request = Access::Favorite.find_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert request.success
      assert_kind_of Access::FavoriteResponse, request
      Access::Favorite.create_location @@offer.location.location_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
    end
  end

  def test_favorite_delete_store
    VCR.use_cassette('favorite/delete_store') do
      Access::Favorite.delete_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'] # create it first, in case it was deleted
      request = Access::Favorite.find_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
      assert request.success
      assert_kind_of Access::FavoriteResponse, request
      Access::Favorite.create_store @@offer.store.store_key, member_key: 'API_TEST', access_token: ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS']
    end
  end

  def assert_good_favorite_offer_response(request)
    assert request.success
    assert_kind_of Access::FavoriteResponse, request
    assert_kind_of Array, request.favorites
    assert_equal 1, request.favorites.map(&:favorite_type).uniq.count
    assert_equal 'offer', request.favorites.map(&:favorite_type).uniq.first
    assert_kind_of Access::Favorite, request.favorites.first
    # assert_kind_of Access::Offer, request.favorites.first.offer if request.favorites.first.respond_to?('offer') # This test will go once the favorites api is pulling from elasticsearch
  end

  def assert_good_favorite_location_response(request)
    assert request.success
    assert_kind_of Access::FavoriteResponse, request
    assert_kind_of Array, request.favorites
    assert_equal 1, request.favorites.map(&:favorite_type).uniq.count
    assert_equal 'location', request.favorites.map(&:favorite_type).uniq.first
    assert_kind_of Access::Favorite, request.favorites.first
    # assert_kind_of Access::Location, request.favorites.first.location
  end

  def assert_good_favorite_store_response(request)
    assert request.success
    assert_kind_of Access::FavoriteResponse, request
    assert_kind_of Array, request.favorites
    assert_equal 1, request.favorites.map(&:favorite_type).uniq.count
    assert_equal 'store', request.favorites.map(&:favorite_type).uniq.first
    assert_kind_of Access::Favorite, request.favorites.first
    # assert_kind_of Access::Store, request.favorites.first.store
  end

end

