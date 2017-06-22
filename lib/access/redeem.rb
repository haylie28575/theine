module Access
  class Redeem
    include Access::MuchMeta

    def self.redeem_offer(offer_key, redeem_type = nil, options = {})
      Access::Api.new.redeem_offer offer_key, redeem_type, options
    end

    def self.process_batch(chunk)
      chunk.map { |redeem| new(redeem) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end
