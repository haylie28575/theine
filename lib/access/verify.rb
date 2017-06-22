module Access
  class Verify
    include Access::MuchMeta

    def self.token(options = {})
      Access::Api.new.verify_token options
    end

    def self.filter(filter, options = {})
      Access::Api.new.verify_filter filter, options
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @categories = Access::Category.process_batch(@categories) if @categories
      @redemption_methods = Access::Redeem.process_batch(@redemption_methods) if @redemption_methods
    end

  end
end
