require './test/test_helper'

class ReportTest < Minitest::Test

  def test_all_usage
    VCR.use_cassette('report/all_usage') do
      reports_response = Access::Report.all_usage api_environment: 'demo'
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.api_calls_over_time
      assert_kind_of Access::Report, reports_response.api_calls_over_time.first
    end
  end

  def test_usage
    VCR.use_cassette('report/usage') do
      reports_response = Access::Report.usage api_environment: 'demo'
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.api_calls_over_time
      assert_kind_of Access::Report, reports_response.api_calls_over_time.first
    end
  end

  def test_usage_other
    VCR.use_cassette('report/usage_other') do
      reports_response = Access::Report.usage_other(ENV['ACCESS_TOKEN'], api_environment: 'demo')
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.api_calls_over_time
      assert_kind_of Access::Report, reports_response.api_calls_over_time.first
    end
  end

  def test_member_query_frequent
    VCR.use_cassette('report/member_query_frequent') do
      reports_response = Access::Report.member_query_frequent('API_RUBY_GEM_TEST', api_environment: 'demo')
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.member_usage
      if reports_response.member_usage.first
        assert_kind_of Access::Report, reports_response.member_usage.first
      end
    end
  end

  def test_member_query_recent
    VCR.use_cassette('report/member_query_recent') do
      reports_response = Access::Report.member_query_recent('API_RUBY_GEM_TEST', api_environment: 'demo')
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.member_usage
      if reports_response.member_usage.first
        assert_kind_of Access::Report, reports_response.member_usage.first
      end
    end
  end

  def test_member_location_frequent
    VCR.use_cassette('report/member_location_frequent') do
      reports_response = Access::Report.member_location_frequent('API_RUBY_GEM_TEST', api_environment: 'demo')
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.member_usage
      if reports_response.member_usage.first
        assert_kind_of Access::Report, reports_response.member_usage.first
      end
    end
  end

  def test_member_location_recent
    VCR.use_cassette('report/member_location_recent') do
      reports_response = Access::Report.member_location_recent('API_RUBY_GEM_TEST', api_environment: 'demo')
      assert reports_response.success
      assert_kind_of Access::Info, reports_response.info
      assert_kind_of Array, reports_response.member_usage
      if reports_response.member_usage.first
        assert_kind_of Access::Report, reports_response.member_usage.first
      end
    end
  end

end
