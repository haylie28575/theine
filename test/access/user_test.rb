require './test/test_helper'

class UserTest < Minitest::Test

  def test_user_register_success
    VCR.use_cassette('user_register/success') do
      request = Access::User.register registration_params.merge(api_environment: 'stage')
      assert request.success
      assert_kind_of Access::UserResponse, request
      assert_kind_of Array, request.users
      assert_equal 1, request.users.count
      assert_kind_of Access::Member, request.users.first
    end
  end

  def test_user_register_failure
    VCR.use_cassette('user_register/failure') do
      request = Access::User.register registration_params.merge(email: nil, api_environment: 'stage')
      refute request.success
      assert_equal 400, request.status
      assert_kind_of Access::UserResponse, request
      refute_nil request.error
      assert_kind_of Access::Error, request.error
    end
  end

  def test_user_update_success
    VCR.use_cassette('user_update/success') do
      request = Access::User.update email: 'cs@test.com', password: 'password', api_environment: 'stage', program_id: '2412', postal_code: '84101', member_key: '226872'
      assert request.success
      assert_kind_of Access::UserResponse, request
      assert_kind_of Array, request.members
      assert_equal 1, request.members.count
      assert_kind_of Access::Member, request.members.first
      assert_kind_of Access::Member, request.members.first.member
      assert_kind_of Access::Organization, request.members.first.organization
      assert_kind_of Access::Program, request.members.first.program
      assert_kind_of Access::User, request.members.first.user
    end
  end

  def test_authenticate_success
    VCR.use_cassette('member_authenticate/success') do
      request = Access::User.authenticate email: 'ben@test.com', password: 'password', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::UserResponse, request
      assert_kind_of Array, request.users
      assert_equal 1, request.users.count
      assert_kind_of Access::Member, request.users.first
    end
  end

  def test_authenticate_failure
    VCR.use_cassette('member_authenticate/failure') do
      request = Access::User.authenticate email: 'ben@test.com', password: 'bad', api_environment: 'stage'
      refute request.success
      assert_equal 401, request.status
      assert_kind_of Access::UserResponse, request
      refute_nil request.error
      assert_kind_of Access::Error, request.error
    end
  end

  def test_authenticate_cvt_success
    VCR.use_cassette('member_authenticate/cvt_success') do
      request = Access::User.authenticate_by_cvt cvt: '6fa6c66c4edc07b767f147a6e5fc614c20797ef0', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::UserResponse, request
      assert_kind_of Array, request.users
      assert_equal 1, request.users.count
      assert_kind_of Access::Member, request.users.first
    end
  end

  def test_authenticate_cvt_failure
    VCR.use_cassette('member_authenticate/cvt_failure') do
      request = Access::User.authenticate_by_cvt cvt: 'thisisaverybadcvtman1234556badbadbad', api_environment: 'stage'
      refute request.success
      assert_equal 401, request.status
      assert_kind_of Access::UserResponse, request
      refute_nil request.error
      assert_kind_of Access::Error, request.error
    end
  end

  def test_authenticate_member_key_success
    VCR.use_cassette('member_authenticate/member_key_success') do
      request = Access::User.authenticate_by_member_key member_key: '226872', api_environment: 'stage'
      assert request.success
      assert_kind_of Access::UserResponse, request
      assert_kind_of Array, request.users
      assert_equal 1, request.users.count

      assert_kind_of Access::Member, request.users.first
    end
  end

  def test_authenticate_member_key_failure
    VCR.use_cassette('member_authenticate/member_key_failure') do
      request = Access::User.authenticate_by_member_key member_key: 'thisisaverybadmember_keyman1234556badbadbad', api_environment: 'stage'
      refute request.success
      assert_equal 401, request.status
      assert_kind_of Access::UserResponse, request
      refute_nil request.error
      assert_kind_of Access::Error, request.error
    end
  end

  def registration_params
    {
      program_id: 2412,
      first_name: 'RubyGem',
      last_name: 'Test',
      postal_code: 84047,
      email: "rubygemtest-6@accessdevelopment.com",
      password: 'test1234',
      shared_secret: 'thanks',
      program_url: "saversclub.accessdevelopment.com",
      access_timeout: 180
    }
  end

end
