module Access
  class Product
    include Access::MuchMeta

    attr_reader :store, :location

    def self.process_batch(chunk)
      chunk.map { |product| new(product) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @offer = Access::Offer.new(@offer) if @offer
      @offer_store = Access::Store.new(@offer_store) if @offer_store
      @categories = Access::Category.process_batch(@categories) if @categories
      @links = Access::Link.new(@links) if @links
      @offer_store = Access::Store.new(@offer_store) if @offer_store
      @offer_uses_remaining = Access::Redemption.new(@offer_uses_remaining) if @offer_uses_remaining
    end

    def location
      @offer_store.physical_location
    end

    def store
      @offer_store
    end

  end
end
