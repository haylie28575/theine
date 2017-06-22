module Access
  class Program
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |program| new(program) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

    def self.find_provisioning_method(pcid)
      Access::Api.new.find_program_provisioning_method pcid
    end
  end
end
