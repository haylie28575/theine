require './test/test_helper'

class FilterTest < Minitest::Test

  def get_first_filter
    VCR.use_cassette('filter/search_first') do
      @first_filter = Access::Filter.search(per_page: 1).filters.first
    end
  end

  def test_filters_search
    VCR.use_cassette('filter/search') do
      filters_response = Access::Filter.search(per_page: 1)
      assert filters_response.success
      first_filter = filters_response.filters.first
      assert_kind_of Access::FilterResponse, filters_response
      assert_kind_of Access::Link, filters_response.links
      assert_kind_of Access::Info, filters_response.info
      assert_kind_of Array, filters_response.filters
      assert_kind_of Access::Filter, first_filter
    end
  end

  def test_filters_find
    get_first_filter
    VCR.use_cassette('filter/find') do
      filters_response = Access::Filter.find(@first_filter.filter_id)
      assert filters_response.success
      first_filter = filters_response.filters.first
      assert_kind_of Access::FilterResponse, filters_response
      assert_kind_of Array, filters_response.filters
      assert_kind_of Access::Filter, first_filter
      assert first_filter.filter_key
      assert first_filter.name
    end
  end

end
