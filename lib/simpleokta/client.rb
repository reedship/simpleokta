require 'http'
require 'json'
require 'erb'
require 'simpleokta/apps'
require 'simpleokta/auth_servers'
require 'simpleokta/groups'
require 'simpleokta/constants'
require 'simpleokta/system_logs'
require 'simpleokta/users'

module Simpleokta
  class Client
    include Apps
    include AuthServers
    include Groups
    include Constants
    include SystemLogs
    include Users

    attr_accessor :api_token, :base_api_url

    # Initialize using passed in config hash
    # @param config [Hash]
    def initialize(config)
      @api_token = config[:api_token]
      @base_api_url = config[:base_api_url]
      @http ||= HTTP.persistent(@base_api_url)
    end

    # This method will add our api_token to each authorization header to keep our code D.R.Y
    # @param action [String] the HTTP verb we are sending our request with.
    #   IE: 'get', 'post', 'put', 'delete'
    # @param url [String] the URL to send the request to.
    # @param body [Hash] the request body, set to an empty hash by default.
    #   Each request may require a different body schema.
    def call_with_token(action, url, body={})
      @http.headers(:accept => 'application/json', :content => 'application/json')
        .auth("SSWS #{@api_token}")
        .send(action, url, :json => JSON[body])
    end
  end
end
