require './test/test_helper'

class CategoryTest < Minitest::Test

  def get_first_category
    VCR.use_cassette('category/search_first') do
      @first_category = Access::Category.search(member_key: 'API_RUBY_GEM_TEST').categories.first
      @first_subcategory = Access::Category.search(member_key: 'API_RUBY_GEM_TEST').categories.first.subcategories.first
    end
  end

  def test_categories_search
    VCR.use_cassette('category/search') do
      categories_response = Access::Category.search(member_key: 'API_RUBY_GEM_TEST')
      assert categories_response.success
      first_category = categories_response.categories.first
      assert_kind_of Access::CategoryResponse, categories_response
      assert_kind_of Array, categories_response.categories
      assert_kind_of Access::Category, first_category
      assert_kind_of Access::Link, first_category.links
      assert_kind_of Access::Category, first_category.subcategories.first
    end
  end

  def test_categories_find
    get_first_category
    VCR.use_cassette('category/find') do
      categories_response = Access::Category.find(@first_category.category_key, member_key: 'API_RUBY_GEM_TEST')
      assert categories_response.success
      first_category = categories_response.categories.first
      assert_kind_of Access::CategoryResponse, categories_response
      assert_kind_of Access::Category, first_category
      assert_kind_of Access::Link, first_category.links
      assert_kind_of Access::Category, first_category.subcategories.first
    end
  end

  def test_subcategories_find
    get_first_category
    VCR.use_cassette('category/subcategory_find') do
      categories_response = Access::Category.find(@first_subcategory.category_key, member_key: 'API_RUBY_GEM_TEST')
      assert categories_response.success
      first_category = categories_response.categories.first
      assert_kind_of Access::CategoryResponse, categories_response
      assert_kind_of Access::Category, first_category
      assert_kind_of Access::Link, first_category.links
      assert_kind_of Access::Category, first_category.subcategory_siblings.first
    end
  end

  def test_categories_fail_member_key
    VCR.use_cassette('category/search_fail_member_key') do
      subcategories_response = Access::Category.search(query: 'pizza')
      refute subcategories_response.success
      assert_kind_of Access::CategoryResponse, subcategories_response
      assert_kind_of Access::Error, subcategories_response.error
      assert_equal 401,  subcategories_response.error.status_code
      assert_equal "Must include a member_key to see details.",  subcategories_response.error.message
      assert_equal "Unauthorized",  subcategories_response.error.status
    end
  end

end
