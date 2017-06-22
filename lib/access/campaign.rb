module Access
  class Campaign
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_campaigns options
    end

    def self.find(campaign_key, options = {})
      Access::Api.new.find_campaign campaign_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |campaign| new(campaign) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @spots = Access::Spot.process_batch(@spots) if @spots
      @spot_list = Access::Spot.process_batch(@spot_list) if @spot_list
      @channels = Access::Channel.process_batch(@channels) if @channels
      @channel_list = Access::Channel.process_batch(@channel_list) if @channel_list
      @links = Access::Link.process_batch(@links) if @links
    end

  end
end
