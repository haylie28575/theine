module Access
  class ProductGroup
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_product_groups options
    end

    def self.process_batch(chunk)
      chunk.map { |product_group| new(product_group) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @products = Access::Product.process_batch(@products) if @products
    end

  end
end
