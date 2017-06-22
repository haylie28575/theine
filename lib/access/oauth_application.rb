module Access
  class OauthApplication
    include Access::MuchMeta

    def self.search(options = {})
      # Internal Admin only Call
      Access::Api.new.search_oauth_applications options
    end

    def self.find(application_id, options = {})
      # Internal Admin only Call
      Access::Api.new.find_oauth_application application_id, options
    end

    def self.search_tokens(application_id, options = {})
      # Internal Admin only Call
      # Returns Token Response
      Access::Api.new.search_oauth_application_tokens application_id, options
    end

    def self.find_token(application_id, token_id, options = {})
      # Internal Admin only Call
      # Returns Token Response
      Access::Api.new.find_oauth_application_token application_id, token_id, options
    end

    def self.create_token(application_id, options = {})
      # Internal Admin only Call
      Access::Api.new.create_oauth_application_token application_id, options
    end

    def self.create(options = {})
      # Internal Admin only Call
      Access::Api.new.create_oauth_application options
    end

    def self.update(application_id, options = {})
      # Internal Admin only Call
      Access::Api.new.update_oauth_application application_id, options
    end

    def self.delete(application_id, options = {})
      # Internal Admin only Call
      Access::Api.new.delete_oauth_application application_id, options
    end

    def self.process_batch(chunk)
      chunk.map { |application| new(application) }
    end

    def initialize(values)
      @used_fields = []
      set_up_methods(values)
      set_values(values)
      @links = Access::Link.new(@links) if @links
      @filter = Access::Filter.new(@filter) if @filter
    end

    def has_scope?(scope)

    end

    def oauth_application_key
      @id
    end

  end
end
