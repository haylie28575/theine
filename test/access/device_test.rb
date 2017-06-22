require './test/test_helper'

class DeviceTest < Minitest::Test

  def test_device_search_success
    VCR.use_cassette('member_device/search_success') do
      request = Access::Device.search '226872', program_id: '2412', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::DeviceResponse, request
      assert_kind_of Hash, request.response
    end
  end

  def test_device_search_failure
    VCR.use_cassette('member_device/search_failure') do
      request = Access::Device.search '12345', program_id: '00112233', api_environment: 'stage'
      assert_equal 404, request.status
      assert_kind_of Access::DeviceResponse, request
      assert_kind_of Hash, request.response
    end
  end

  def test_device_find_success
    skip
    VCR.use_cassette('member_device/find_success') do
      request = Access::Device.search '226872', udid: 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', program_id: '2412', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::DeviceResponse, request
      assert_kind_of Hash, request.response
    end
  end

  def test_device_find_failure
    skip
    VCR.use_cassette('member_device/find_failure') do
      request = Access::Device.search '226872', udid: 'YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY', program_id: '2412', api_environment: 'stage'
      assert_equal 404, request.status
      assert_kind_of Access::DeviceResponse, request
      assert_kind_of Hash, request.response
    end
  end

end
