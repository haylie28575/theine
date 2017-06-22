require './test/test_helper'

class LocationTest < Minitest::Test

  def get_first_location
    VCR.use_cassette('location/search_first') do
      @first_location = Access::Location.search(member_key: 'API_RUBY_GEM_TEST', per_page: 1).locations.first
    end
  end

  def test_locations_search
    VCR.use_cassette('location/search') do
      locations_response = Access::Location.search(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert locations_response.success
      first_location = locations_response.locations.first
      assert_kind_of Access::LocationResponse, locations_response
      assert_kind_of Access::Link, locations_response.links
      assert_kind_of Access::Info, locations_response.info
      assert_kind_of Array, locations_response.locations
      assert_kind_of Access::Location, first_location
      assert_kind_of Access::Link, first_location.links
      assert_kind_of Access::Category, first_location.location_categories.first
      assert_kind_of Access::Location, first_location.physical_location
      assert_kind_of Access::Store, first_location.location_store
      assert_kind_of Access::Geolocation, first_location.physical_location.geolocation
      # make these work
      # assert_kind_of Access::Category, first_location.categories
      # assert_kind_of Access::Store, first_location.store
      # assert_kind_of Access::Store, first_location.location
      # assert first_location.name
    end
  end

  def test_locations_find
    get_first_location
    VCR.use_cassette('location/find') do
      locations_response = Access::Location.find(@first_location.location_key, member_key: 'API_RUBY_GEM_TEST')
      assert locations_response.success
      first_location = locations_response.locations.first
      assert_kind_of Access::LocationResponse, locations_response
      assert_kind_of Access::Location, first_location
      assert_kind_of Access::Category, first_location.location_categories.first
      assert_kind_of Access::Location, first_location.physical_location
      assert_kind_of Access::Store, first_location.location_store
      assert_kind_of Access::Geolocation, first_location.physical_location.geolocation
    end
  end

  def test_locations_fail_member_key
    VCR.use_cassette('location/search_fail_member_key') do
      locations_response = Access::Location.search(query: 'pizza')
      refute locations_response.success
      assert_kind_of Access::LocationResponse, locations_response
      assert_kind_of Access::Error, locations_response.error
      assert_equal 401,  locations_response.error.status_code
      assert_equal "Must include a member_key to see details.",  locations_response.error.message
      assert_equal "Unauthorized",  locations_response.error.status
    end
  end

end
