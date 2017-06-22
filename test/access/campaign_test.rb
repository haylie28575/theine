require './test/test_helper'

class CampaignTest < Minitest::Test

  def get_first_campaign
    VCR.use_cassette('campaign/search_first') do
      @first_campaign = Access::Campaign.search(member_key: 'API_RUBY_GEM_TEST', channel_key: '20889899', api_environment: 'production').campaigns.first
    end
  end

  def test_campaigns_search
    VCR.use_cassette('campaign/search') do
      campaigns_response = Access::Campaign.search(member_key: 'API_RUBY_GEM_TEST', channel_key: '20889899', api_environment: 'production')
      assert campaigns_response.success
      first_campaign = campaigns_response.campaigns.first
      assert_kind_of Access::CampaignResponse, campaigns_response
      assert_kind_of Array, campaigns_response.campaigns
      assert_kind_of Access::Campaign, first_campaign
      assert_kind_of Access::Link, first_campaign.links.first
      assert_kind_of Array, first_campaign.spots
      assert_kind_of Access::Spot, first_campaign.spots.first
      assert_kind_of Access::Link, first_campaign.spots.first.links.first
      assert_kind_of Array, first_campaign.channels
      assert_kind_of Access::Channel, first_campaign.channels.first
      assert_kind_of Access::Link, first_campaign.channels.first.links.first
    end
  end

  def test_campaigns_find
    skip
    get_first_campaign
    VCR.use_cassette('campaign/find') do
      campaigns_response = Access::Campaign.find(@first_campaign.key, member_key: 'API_RUBY_GEM_TEST', channel_key: '20889899', api_environment: 'production')
      assert campaigns_response.success
      assert_kind_of Access::CampaignResponse, campaigns_response
      base_attributes = [:key, :campaign_name, :campaign_description, :start_date, :end_date, :campaign_ranking, :spot_list, :channel_list, :links]
      base_attributes.each do |att|
        assert campaigns_response.respond_to?(att), "#{att} not found"
      end
      assert_kind_of Array, campaigns_response.spot_list
      assert_kind_of Access::Spot, campaigns_response.spot_list.first
      assert_kind_of Access::Link, campaigns_response.spot_list.first.links.first
      assert_kind_of Array, campaigns_response.channel_list
      assert_kind_of Access::Channel, campaigns_response.channel_list.first
      assert_kind_of Access::Link, campaigns_response.channel_list.first.links.first
      assert_kind_of Array, campaigns_response.links
      assert_kind_of Access::Link, campaigns_response.links.first
    end
  end

end
