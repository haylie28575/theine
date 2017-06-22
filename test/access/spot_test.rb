require './test/test_helper'

class SpotTest < Minitest::Test

  def get_first_spot
    VCR.use_cassette('spot/search_by_channel_first') do
      @first_spot = Access::Spot.search_by_channel('20889899', member_key: 'API_RUBY_GEM_TEST', api_environment: 'production').spots.first
    end
  end

  def test_spots_search_by_channel
    VCR.use_cassette('spot/search_by_channel') do
      spots_response = Access::Spot.search_by_channel('20889899', member_key: 'API_RUBY_GEM_TEST', api_environment: 'production')
      assert spots_response.success
      first_spot = spots_response.spots.first
      assert_kind_of Access::SpotResponse, spots_response
      assert_kind_of Array, spots_response.spots
      assert_kind_of Access::Spot, first_spot
      assert_kind_of Access::Link, first_spot.links.first
      assert_kind_of Access::Offer, first_spot.offer_resource
    end
  end

  def test_spots_search_by_campaign
    VCR.use_cassette('spot/search_by_campaign') do
      spots_response = Access::Spot.search_by_campaign('53', member_key: 'API_RUBY_GEM_TEST', api_environment: 'production')
      assert spots_response.success
      first_spot = spots_response.spots.first
      assert_kind_of Access::SpotResponse, spots_response
      assert_kind_of Array, spots_response.spots
      assert_kind_of Access::Spot, first_spot
      assert_kind_of Access::Link, first_spot.links.first
      assert_kind_of Access::Offer, first_spot.offer_resource
    end
  end

  def test_spots_find
    get_first_spot
    VCR.use_cassette('spot/find') do
      spots_response = Access::Spot.find(@first_spot.key, member_key: 'API_RUBY_GEM_TEST', api_environment: 'production')
      assert spots_response.success
      assert_kind_of Access::SpotResponse, spots_response
      base_attributes = [:key, :spot_name, :spot_text, :start_date, :end_date, :spot_ranking, :spot_redirect_url, :spot_redirect_type, :spot_image_url, :links]
      base_attributes.each do |att|
        assert spots_response.respond_to?(att), "#{att} not found"
      end
    end
  end

end
