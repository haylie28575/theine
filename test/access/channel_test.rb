require './test/test_helper'

class ChannelTest < Minitest::Test

  def get_first_channel
    VCR.use_cassette('channel/search_first') do
      @first_channel = Access::Channel.search(member_key: 'API_RUBY_GEM_TEST', api_environment: 'production').channels.first
    end
  end

  def test_channels_search
    VCR.use_cassette('channel/search') do
      channels_response = Access::Channel.search(member_key: 'API_RUBY_GEM_TEST', api_environment: 'production')
      assert channels_response.success
      first_channel = channels_response.channels.first
      assert_kind_of Access::ChannelResponse, channels_response
      assert_kind_of Array, channels_response.channels
      assert_kind_of Access::Channel, first_channel
      assert_kind_of Access::Link, first_channel.links.first
    end
  end

  def test_channels_find
    skip
    get_first_channel
    VCR.use_cassette('channel/find') do
      channels_response = Access::Channel.find(@first_channel.key, member_key: 'API_RUBY_GEM_TEST', api_environment: 'production')
      assert channels_response.success
      assert_kind_of Access::ChannelResponse, channels_response
      base_attributes = [:key, :channel_name, :channel_type, :channel_identifier, :channel_description, :links]
      base_attributes.each do |att|
        assert channels_response.respond_to?(att), "#{att} not found"
      end
      assert_kind_of Array, channels_response.links
      assert_kind_of Access::Link, channels_response.links.first
    end
  end

end
