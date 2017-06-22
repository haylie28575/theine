require './test/test_helper'

class AutocompleteTest < Minitest::Test

  def test_autocompletes_search
    VCR.use_cassette('autocomplete/search_first') do
      autocompletes_response = Access::Autocomplete.search(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert autocompletes_response.success
      assert_kind_of Access::AutocompleteResponse, autocompletes_response
      assert_kind_of Access::Autocomplete, autocompletes_response.suggestions
      assert_kind_of Access::Store, autocompletes_response.suggestions.stores.first
      assert_kind_of Access::Location, autocompletes_response.suggestions.locations.first
      assert_kind_of Access::Category, autocompletes_response.suggestions.categories.first
      assert_kind_of Access::Offer, autocompletes_response.suggestions.offers.first
    end
  end

  def test_autocompletes_search_offers
    VCR.use_cassette('autocomplete/search_offers') do
      autocompletes_response = Access::Autocomplete.search_offers(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert autocompletes_response.success
      assert_kind_of Array, autocompletes_response.suggestions.offers
      assert_kind_of Access::Offer, autocompletes_response.suggestions.offers.first
    end
  end

  def test_autocompletes_search_stores
    VCR.use_cassette('autocomplete/search_stores') do
      autocompletes_response = Access::Autocomplete.search_stores(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert autocompletes_response.success
      assert_kind_of Array, autocompletes_response.suggestions.stores
      assert_kind_of Access::Store, autocompletes_response.suggestions.stores.first
    end
  end

  def test_autocompletes_search_locations
    VCR.use_cassette('autocomplete/search_locations') do
      autocompletes_response = Access::Autocomplete.search_locations(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert autocompletes_response.success
      assert_kind_of Array, autocompletes_response.suggestions.locations
      assert_kind_of Access::Location, autocompletes_response.suggestions.locations.first
    end
  end

  def test_autocompletes_search_categories
    VCR.use_cassette('autocomplete/search_categories') do
      autocompletes_response = Access::Autocomplete.search_categories(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert autocompletes_response.success
      assert_kind_of Array, autocompletes_response.suggestions.categories
      assert_kind_of Access::Category, autocompletes_response.suggestions.categories.first
    end
  end
end
