module Access
  class Redemption
    include Access::MuchMeta

    def self.search_by_member(member_key, options = {})
      Access::Api.new.search_offer_redemptions_by_member member_key, options
    end

    def self.find_by_member(member_key, usage_redeem_key, options = {})
      Access::Api.new.find_offer_redemptions_by_member member_key, usage_redeem_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |redemption| new(redemption) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @offer = Access::Offer.new(@offer) if @offer
      @member = Access::Member.new(@member) if @member
    end

  end
end
