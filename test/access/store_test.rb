require './test/test_helper'

class StoreTest < Minitest::Test

  def get_first_store
    VCR.use_cassette('store/search_first') do
      @first_store = Access::Store.search(member_key: 'API_RUBY_GEM_TEST', per_page: 1).stores.first
    end
  end

  def test_stores_search
    VCR.use_cassette('store/search') do
      stores_response = Access::Store.search(member_key: 'API_RUBY_GEM_TEST', per_page: 1)
      assert stores_response.success
      first_store = stores_response.stores.first
      assert_kind_of Access::StoreResponse, stores_response
      assert_kind_of Access::Link, stores_response.links
      assert_kind_of Access::Info, stores_response.info
      assert_kind_of Array, stores_response.stores
      assert_kind_of Access::Store, first_store
      assert_kind_of Access::Link, first_store.links
      assert_kind_of Access::Category, first_store.store_categories.first

      # things to add
      # assert_kind_of Access::Category, first_store.categories
    end
  end

  def test_stores_find
    get_first_store
    VCR.use_cassette('store/find') do
      stores_response = Access::Store.find(@first_store.store_key, member_key: 'API_RUBY_GEM_TEST')
      assert stores_response.success
      first_store = stores_response.stores.first
      # pp stores_response.inspect
      assert_kind_of Access::StoreResponse, stores_response
      assert_kind_of Access::Store, first_store
      assert_kind_of Access::Link, first_store.links
      assert_kind_of Access::Category, first_store.store_categories.first
    end
  end

  def test_national_stores_find
    VCR.use_cassette('store/national_stores') do
      stores_response = Access::Store.national(per_page: 1, member_key: 'API_RUBY_GEM_TEST')
      assert stores_response.success
      first_store = stores_response.stores.first
      assert_kind_of Access::StoreResponse, stores_response
      assert_kind_of Access::Store, first_store
    end
  end

  def test_stores_fail_member_key
    VCR.use_cassette('store/search_fail_member_key') do
      stores_response = Access::Store.search(query: 'pizza')
      refute stores_response.success
      assert_kind_of Access::StoreResponse, stores_response
      assert_kind_of Access::Error, stores_response.error
      assert_equal 401,  stores_response.error.status_code
      assert_equal "Must include a member_key to see details.",  stores_response.error.message
      assert_equal "Unauthorized",  stores_response.error.status
    end
  end

end
