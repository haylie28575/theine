module Access
  class Amt
    include Access::MuchMeta

    def self.import(members = [], options = {})
      Access::Api.new.import_members members, options
    end

    def self.list(options = {})
      Access::Api.new.list_imports options
    end

    def self.show(import_key, options = {})
      Access::Api.new.show_import import_key, options
    end

    def self.process_batch(chunk)
      chunk.map { |member_import| new(member_import) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

  end
end
