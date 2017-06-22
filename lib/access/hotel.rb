module Access
  class Hotel
    include Access::MuchMeta
    
    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

    def self.search(options = {})
      Access::Api.new.search_hotels options
    end 

    def self.find(hotel_key, options = {})
      Access::Api.new.find_hotel hotel_key, options
    end

    def self.process_batch(chunk)
      chunk = JSON.parse(chunk.to_json, object_class: OpenStruct)
    end
  end
end