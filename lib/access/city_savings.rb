module Access
  class CitySavings
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_city_savings options
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end
