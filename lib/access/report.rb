module Access
  class Report
    include Access::MuchMeta

    def self.all_usage(options = {})
      # Internal Admin only Call
      Access::Api.new.all_usage options
    end

    def self.usage(options = {})
      # Internal Admin only Call
      Access::Api.new.usage options
    end

    def self.usage_other(key, options = {})
      # Internal Admin only Call
      Access::Api.new.usage_other key, options
    end

    def self.member_query_frequent(member, options = {})
      Access::Api.new.member_query_frequent member, options
    end

    def self.member_query_recent(member, options = {})
      Access::Api.new.member_query_recent member, options
    end

    def self.member_location_frequent(member, options = {})
      Access::Api.new.member_location_frequent member, options
    end

    def self.member_location_recent(member, options = {})
      Access::Api.new.member_location_recent member, options
    end

    def self.process_batch(chunk)
      chunk.map { |data| new(data) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end
