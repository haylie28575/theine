module Access
  class Channel
    include Access::MuchMeta

    def self.search(options = {})
      Access::Api.new.search_channels options
    end

    def self.find(channel_key, options = {})
      Access::Api.new.find_channel channel_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |channel| new(channel) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @links = Access::Link.process_batch(@links) if @links
    end

  end
end
