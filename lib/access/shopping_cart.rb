module Access
  class ShoppingCart
    include Access::MuchMeta

    def self.get_count(options={})
      Access::Api.new.get_shopping_cart_count options
    end

  end
end
