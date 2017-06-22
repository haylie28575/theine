module Access
  class Store
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_stores options
    end

    def self.find(store_key, options = {})
      Access::Api.new.find_store store_key, options
    end

    def self.national(options = {})
      Access::Api.new.national_stores options
    end

    def self.process_batch(chunk)
      chunk.map { |store| new(store) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @links = Access::Link.new(@links) if @links
      @store_categories = Access::Category.process_batch(@store_categories) if @store_categories
      @physical_location = Access::Location.new(@physical_location) if @physical_location
    end

  end
end
