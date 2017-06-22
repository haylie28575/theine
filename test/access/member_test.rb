require './test/test_helper'

class MemberTest < Minitest::Test

  def test_member_show_success
    VCR.use_cassette('member/show_success') do
      request = Access::Member.show '226872', program_id: '2412', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::MemberResponse, request
      assert_kind_of Hash, request.response
    end
  end

  def test_member_show_failure
    VCR.use_cassette('member/show_failure') do
      request = Access::Member.show '12345', program_id: '00112233', api_environment: 'stage'
      assert_equal 404, request.status
      assert_kind_of Access::MemberResponse, request
      assert_kind_of Hash, request.response
    end
  end

  def test_member_update
    VCR.use_cassette('member/update_success') do
      request = Access::Member.update '226872', program_id: '2412', api_environment: 'stage', birth_date: '2016-01-01'
      assert request.success
      assert_kind_of Access::MemberResponse, request
      assert_kind_of Hash, request.response
      assert_equal request.response["birth_date"], '2016-01-01'
    end
  end

end
