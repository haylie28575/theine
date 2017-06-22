module Access
  class Token
    include Access::MuchMeta

    def self.search(options = {})
      # Internal Admin only Call
      Access::Api.new.search_tokens options
    end

    def self.find(token, options = {})
      # Internal Admin only Call
      Access::Api.new.find_token token, options
    end

    def self.process_batch(chunk)
      chunk.map { |token| new(token) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @links = Access::Link.new(@links) if @links
    end

    def has_scope?

    end

  end
end
