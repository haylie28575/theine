module Access
  class Autocomplete
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.autocomplete options
    end

    def self.search_stores(options = {})
      Access::Api.new.autocomplete options.merge(resources: 'stores')
    end

    def self.search_categories(options = {})
      Access::Api.new.autocomplete options.merge(resources: 'categories')
    end

    def self.search_offers(options = {})
      Access::Api.new.autocomplete options.merge(resources: 'offers')
    end

    def self.search_locations(options = {})
      Access::Api.new.autocomplete options.merge(resources: 'locations')
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @offers = Access::Offer.process_batch(@offers) if @offers
      @stores = Access::Store.process_batch(@stores) if @stores
      @locations = Access::Location.process_batch(@locations) if @locations
      @categories = Access::Category.process_batch(@categories) if @categories
    end

  end
end
