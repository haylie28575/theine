module Access
  class User
    include Access::MuchMeta

    def self.process_batch(chunk)
      chunk.map { |user| new(user) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
    end

    def self.register(options = {})
      Access::Api.new.user_registration options
    end

    def self.update(options = {})
      Access::Api.new.user_update options
    end

    def self.authenticate(options = {})
      Access::Api.new.user_authentication options
    end

    def self.authenticate_by_cvt(options = {})
      Access::Api.new.user_authentication_by_cvt options
    end

    def self.authenticate_by_member_key(options = {})
      Access::Api.new.user_authentication_by_member_key options
    end

  end
end
