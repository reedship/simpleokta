require "simpleokta/version"
require "simpleokta/configuration"
require "faraday"

module Simpleokta
  class Error < StandardError; end

  class << self
    attr_accessor :configuration

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.reset
      @configuration = Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end


  class Util
    require 'faraday'
    require 'json'
    require 'erb'

    API_BASE_PATH = '/api/v1'
    USER_API_BASE_PATH = "#{API_BASE_PATH}/users"
    APP_API_BASE_PATH = "#{API_BASE_PATH}/apps"
    AUTH_SERVER_API_BASE_PATH = "#{API_BASE_PATH}/authorizationServers"
    GROUP_API_BASE_PATH = "#{API_BASE_PATH}/groups"
    SYSTEM_LOG_API_BASE_PATH = "#{API_BASE_PATH}/logs"
    ORG_API_BASE_PATH = "#{API_BASE_PATH}/org"

    def initialize(config)
      @base_api_url = config.base_api_url
      @api_token = config.api_token
    end


    def connection
      @conn ||= Faraday.new(@base_api_url)
    end

    def call_with_token(action, url)
      connection.send(action) do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "SSWS #{@api_token}"
      end
    end

    def apps
      response = call_with_token('get', APP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    def apps_assigned_to_user(user_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=user.id+eq+\"#{user_id}\"")
      JSON.parse(response.body)
    end

    def apps_assigned_to_group(group_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=group.id+eq+\"#{group_id}\"")
      JSON.parse(response.body)
    end

    def app(app_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}")
      JSON.parse(response.body)
    end

    def auth_servers
      response = call_with_token('get', AUTH_SERVER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    def groups
      response = call_with_token('get', GROUP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    def logs(time_range:, event:)
      pass
    end

    def users
      response = call_with_token('get', USER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    def user(user_id)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{user_id}")
      JSON.parse(response.body)
    end

    def user_from_login(login)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{ERB::Util.url_encode(login)}")
      JSON.parse(response.body)
    end
  end
end
