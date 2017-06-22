module Access
  class Geolocation
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.geolocation_search options
    end

    def self.find(options = {})
      Access::Api.new.geolocation_find options
    end

    def self.process_batch(chunk)
      chunk.map { |geolocation| new(geolocation) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @geolocation = Geolocation.new(@geolocation) if @geolocation
    end

  end
end
