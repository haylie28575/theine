module Access
  class Category
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_categories options
    end

    def self.find(category_key, options = {})
      Access::Api.new.find_category category_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |category| new(category) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @links = Access::Link.new(@links) if @links
      @subcategories = Access::Category.process_batch(@subcategories) if @subcategories
      @subcategory_siblings = Access::Category.process_batch(@subcategory_siblings) if @subcategory_siblings
    end

  end
end
