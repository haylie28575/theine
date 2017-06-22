module Access
  class Filter
    include Access::MuchMeta

    def self.search(options = {})
      # Internal Admin only Call
      Access::Api.new.search_filters options
    end

    def self.find(filter_key, options = {})
      # Internal Admin only Call
      Access::Api.new.find_filter filter_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |filter| new(filter) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

    def filter_key
      @filter_id
    end

    def name
      @filter_name
    end

  end
end
