module Access
  class Favorite
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |favorite| new(favorite) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @offer = Access::Offer.new(@offer) if @offer
      @location = Access::Location.new(@location) if @location
      @store = Access::Store.new(@store) if @store

    end

    def resource
      self.send(self.favorite_type)
    end

    # search / index

    def self.search(options = {})
      Access::Api.new.favorites_search options
    end

    def self.search_offers(options = {})
      Access::Api.new.favorites_search options.merge(favorite_type: 'offers')
    end

    def self.search_locations(options = {})
      Access::Api.new.favorites_search options.merge(favorite_type: 'locations')
    end

    def self.search_stores(options = {})
      Access::Api.new.favorites_search options.merge(favorite_type: 'stores')
    end

    # find / show

    def self.find(resource_id, options = {})
      # must pass in a favorite_type
      Access::Api.new.favorites_find resource_id, options
    end

    def self.find_offer(offer_key, options = {})
      Access::Api.new.favorites_find offer_key, options.merge(favorite_type: 'offers')
    end

    def self.find_location(location_key, options = {})
      Access::Api.new.favorites_find location_key, options.merge(favorite_type: 'locations')
    end

    def self.find_store(store_key, options = {})
      Access::Api.new.favorites_find store_key, options.merge(favorite_type: 'stores')
    end

    # create

    def self.create(resource_key, options = {})
      # must pass in a favorite_type
      Access::Api.new.favorites_create resource_key, options
    end

    def self.create_offer(offer_key, options = {})
      Access::Api.new.favorites_create offer_key, options.merge(favorite_type: 'offers')
    end

    def self.create_location(location_key, options = {})
      Access::Api.new.favorites_create location_key, options.merge(favorite_type: 'locations')
    end

    def self.create_store(store_key, options = {})
      Access::Api.new.favorites_create store_key, options.merge(favorite_type: 'stores')
    end

    #delete

    def self.delete(offer_key, options = {})
      Access::Api.new.favorites_delete offer_key, options
    end

    def self.delete_offer(offer_key, options = {})
      Access::Api.new.favorites_delete offer_key, options.merge(favorite_type: 'offers')
    end

    def self.delete_location(location_key, options = {})
      Access::Api.new.favorites_delete location_key, options.merge(favorite_type: 'locations')
    end

    def self.delete_store(store_key, options = {})
      Access::Api.new.favorites_delete store_key, options.merge(favorite_type: 'stores')
    end

  end
end
