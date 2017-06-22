module Access
  class Aggregations
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |aggs| new(aggs) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @subcategories = Access::Category.process_batch(@subcategories) if @subcategories
      @facets = Access::Aggregations.process_batch(@facets) if @facets
    end

  end
end
