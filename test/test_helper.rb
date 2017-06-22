require 'dotenv'
Dotenv.load

require 'simplecov'
require 'coveralls'
require 'pry'

SimpleCov.start

require './lib/access'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/focus'
require 'webmock/minitest'
require 'vcr'

ACCESS_ENVIRONMENT ||= "stage"

VCR.configure do |c|
  c.default_cassette_options = { record: ENV["RECORD"] ? ENV["RECORD"].to_sym : :new_episodes, match_requests_on: [:body], erb: true }
  c.cassette_library_dir = "test/vcr/cassettes"
  c.hook_into :webmock
  c.ignore_hosts 'codeclimate.com'
  c.filter_sensitive_data('<ACCESS_TOKEN>') { ENV['ACCESS_TOKEN'] }
  c.filter_sensitive_data('<TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS>') { ENV['TOKEN_WITHOUT_FILTERS_WITH_PROGRAM_OFFERS'] }
end
