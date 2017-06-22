module Access
  class << self
    attr_accessor :config
  end

  def self.config
    @config && @config.access_token ? @config : @config = Config.new
  end

  # Set options via block
  def self.configure
    yield(config) if block_given?
  end

  class Config
    DOMAINS = {'production' => '', 'demo' => '-demo', 'stage' => '-stage', 'staging' => '-stage', 'development' => '' }
    attr_accessor :access_token, :api_environment, :return_json, :hashify, :access_timeout, :access_debug_output, :access_used_fields

    def initialize
      @access_token = ENV['ACCESS_TOKEN']
      # demo, stage, production
      @api_environment = ENV['ACCESS_ENVIRONMENT'] || 'demo'
      # @api_version = ENV['ACCESS_VERSION'] || 'v1'
      @return_json = ENV['ACCESS_RETURN_JSON'] || 'false'
      # only used when return_json is true
      @hashify = ENV['ACCESS_HASHIFY'] || 'false'
      # how many seconds till we raise a Access::Error::Timeout
      @access_timeout = ENV['ACCESS_TIMEOUT'] || '10'
      # Set to 'true' to see the raw output of the httparty call
      @access_debug_output = ENV['ACCESS_DEBUG_OUTPUT'] || 'false'
      @access_used_fields = ENV['ACCESS_USED_FIELDS'] || 'false'
    end

    def reset
      self.access_token = ENV['ACCESS_TOKEN']
      self.api_environment = ENV['ACCESS_ENVIRONMENT'] || 'demo'
      # self.api_version = 'v1'
      self.return_json = ENV['ACCESS_RETURN_JSON'] || 'false'
      self.hashify = ENV['ACCESS_HASHIFY'] || 'false'
      self.access_timeout = ENV['ACCESS_TIMEOUT'] || '10'
      self.access_debug_output = ENV['ACCESS_DEBUG_OUTPUT'] || 'false'
      self.access_used_fields = ENV['ACCESS_USED_FIELDS'] || 'false'
    end
  end

end

