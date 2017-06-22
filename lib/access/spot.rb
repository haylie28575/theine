module Access
  class Spot
    include Access::MuchMeta

    def self.search_by_channel(channel_key, options = {})
      Access::Api.new.search_spots_by_channel channel_key, options
    end

    def self.search_by_campaign(campaign_key, options = {})
      Access::Api.new.search_spots_by_campaign campaign_key, options
    end

    def self.find(spot_key, options = {})
      Access::Api.new.find_spot spot_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |spot| new(spot) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @offer_resource = Access::Offer.new(@offer_resource) if @offer_resource
      @campaign_resource = Access::Campaign.new(@campaign_resource) if @campaign_resource
      @links = Access::Link.process_batch(@links) if @links
    end

    def offer
      @offer_resource
    end

    def campaign
      @campaign_resource
    end

  end
end
