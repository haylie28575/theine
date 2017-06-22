module Access
  class Location
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_locations options
    end

    def self.find(location_key, options = {})
      Access::Api.new.find_location location_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |location| new(location) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)

      @links = Access::Link.new(@links) if @links
      @location_store = Access::Store.new(@location_store) if @location_store
      @location_categories = Access::Category.process_batch(@location_categories) if @location_categories
      @physical_location = Access::Location.new(@physical_location) if @physical_location
      @geolocation = Geolocation.new(@geolocation) if @geolocation
    end

  end
end
