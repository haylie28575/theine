module Access
  class Request
    include HTTParty

    attr_reader :url, :headers, :timeout, :return_json, :use_hashify

    def base_setup(path, api_type, options)
      @url = set_base(path, api_type, options.delete(:api_environment))
      @headers = set_headers options.delete(:access_token)
      @timeout = options.delete(:access_timeout) || Access.config.access_timeout
      @return_json = should_return_json?(options.delete(:return_json).to_s)
      @use_hashify = hashify_results?(options.delete(:hashify).to_s)
      @debug_output = options.delete(:access_debug_output).to_s || Access.config.access_debug_output
    end

    def get(path, api_type, options={}, &block)
      base_setup(path, api_type, options)
      results = self.class.get(url, headers: headers, query: options, timeout: timeout, debug_output: (@debug_output == 'true' ? $stdout : nil))
      if return_json
        use_hashify ? results.hashify : results
      else
        block.call results
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      raise Access::Error::Timeout
    rescue EOFError
      raise Access::Error::NoData
    end

    def put(path, api_type, options={}, &block)
      base_setup(path, api_type, options)
      results = self.class.put(url, headers: headers, body: options.to_json, timeout: timeout, debug_output: (@debug_output == 'true' ? $stdout : nil))
      if return_json
        use_hashify ? results.hashify : results
      else
        block.call results
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      raise Access::Error::Timeout
    rescue EOFError
      raise Access::Error::NoData
    end

    def post(path, api_type, options={}, &block)
      base_setup(path, api_type, options)
      results = self.class.post(url, headers: headers, body: options.to_json, timeout: timeout, debug_output: (@debug_output == 'true' ? $stdout : nil))
      if return_json
        use_hashify ? results.hashify : results
      else
        block.call results
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      raise Access::Error::Timeout
    rescue EOFError
      raise Access::Error::NoData
    end

    def delete(path, api_type, options={}, &block)
      base_setup(path, api_type, options)
      results = self.class.delete(url, headers: headers, body: options.to_json, timeout: timeout, debug_output: (@debug_output == 'true' ? $stdout : nil))
      if return_json
        use_hashify ? results.hashify : results
      else
        block.call results
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      raise Access::Error::Timeout
    rescue EOFError
      raise Access::Error::NoData
    end

    def post_for_filter(path, api_type, filter, options={}, &block)
      base_setup(path, api_type, options)
      results = self.class.post(url, headers: headers, body: filter, timeout: timeout, debug_output: (@debug_output == 'true' ? $stdout : nil))
      if return_json
        use_hashify ? results.hashify : results
      else
        block.call results
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      raise Access::Error::Timeout
    rescue EOFError
      raise Access::Error::NoData
    end

    private

    def set_base(path, api_type, environment)
      url = Access.config.api_environment == 'development' ? "http://" : "https://"
      url += api_type
      url += !!environment ? Access::Config::DOMAINS[environment] : Access::Config::DOMAINS[Access.config.api_environment]
      if api_type == "amt"
        url += Access.config.api_environment == 'development' ? ".amt.dev/api/v1" : ".accessdevelopment.com/api/v1"
      else
        url += Access.config.api_environment == 'development' ? ".rws-api.dev/v1" : ".adcrws.com/v1"
      end
      url += path
    end

    def set_headers(token_param)
      raise Access::Error::NoAccessToken if (access_token = token_param || Access.config.access_token).nil?
      {"Access-Token" => access_token, 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
    end

    def should_return_json?(return_json_param)
      return_json_param == 'true' || (return_json_param != 'false' && Access.config.return_json == 'true')
    end

    def hashify_results?(hashify_param)
      hashify_param == 'true' || (hashify_param != 'false' && Access.config.hashify == 'true')
    end

  end
end
