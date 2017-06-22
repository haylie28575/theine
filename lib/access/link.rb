module Access
  class Link
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |link| new(link) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end

