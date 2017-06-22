module Access
  class Device
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |device| new(device) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

    def self.search(member_key, options = {})
      Access::Api.new.search_devices member_key, options
    end

    def self.find(member_key, options = {})
      Access::Api.new.find_device member_key, options
    end

  end
end
