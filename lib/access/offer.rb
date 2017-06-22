module Access
  class Offer
    include Access::MuchMeta

    attr_reader :store, :location

    def self.search(options = {})
      Access::Api.new.search_offers options
    end

    def self.find(offer_key, options = {})
      Access::Api.new.find_offer offer_key, options
    end

    def self.find_uses_remaining(offer_key, options = {})
      Access::Api.new.find_offer_uses_remaining offer_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |offer| new(offer) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @categories = Access::Category.process_batch(@categories) if @categories
      @links = Access::Link.new(@links) if @links
      @offer_store = Access::Store.new(@offer_store) if @offer_store
      @offer_uses_remaining = Access::Redemption.new(@offer_uses_remaining) if @offer_uses_remaining
    end

    def location
      @offer_store.physical_location
    end

    def store
      @offer_store
    end

  end
end
