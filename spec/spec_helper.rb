require "vcr"
require 'simpleokta/client'
require 'dotenv/load'

module AgentsAccessTokenFilter
  private

  def serializable_body(*)
    body = super
    body['string'].gsub!(/"access_token":\s*"\w+"/, '"access_token": "<<AGENT_ACCESS_TOKEN>>"')
    body['string'].gsub!(/"ip_address":\s*"[\d\.]+"/, '"ip_address": "127.0.0.1"')
    body
  end
end

VCR::Response.include(AgentsAccessTokenFilter)
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  VCR.configure do |config|
    config.configure_rspec_metadata!
    config.cassette_library_dir = 'spec/cassettes/'
    config.hook_into(:webmock)
    config.filter_sensitive_data('<<ACCESS_TOKEN>>') do
      fake_okta_api_token
    end
    config.before_record do |i|
      i.response.body.force_encoding('UTF-8')
    end
  end


end


module TestingClient
  extend RSpec::SharedContext
  let(:client) { Simpleokta::Client.new({:api_token => ENV['API_TOKEN'], :base_api_url => ENV['BASE_API_URL']}) }
end

RSpec.configure do |config|
  config.include(TestingClient)
end

def fake_okta_api_token
  ENV.fetch('API_TOKEN', 'x'*40)
end

def fake_base_api_url
  ENV.fetch('BASE_API_URL', 'y'*25)
end
