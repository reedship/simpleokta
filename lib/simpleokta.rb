require "simpleokta/version"
require "simpleokta/configuration"
require "faraday"

# @author Braden Shipley
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

    # Description here
    # @param config [Hash]
    def initialize(config)
      @base_api_url = config.base_api_url
      @api_token = config.api_token
    end


    # Description here
    def connection
      @conn ||= Faraday.new(@base_api_url)
    end

    # This method will add our api_token to each authorization header to keep our code D.R.Y
    # @param action [String] the HTTP verb we are sending our request with.
    #   IE: 'get', 'post', 'put', 'delete'
    # @param url [String] the URL to send the request to.
    # @param body [Hash] the request body, set to an empty hash by default.
    #   Each request may require a different body schema.
    def call_with_token(action, url, body={})
      connection.send(action) do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.headers['Accept'] = 'application/json'
        req.headers['Authorization'] = "SSWS #{@api_token}"
        req.body = body
      end
    end

    # APP METHODS

    # Returns a list of all applications in the okta instance.
    # @return Array<Hash>
    def apps
      response = call_with_token('get', APP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Return a specific application in the okta instance.
    # @param app_id [String] the unique id of the application
    # @return [Hash]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def app(app_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def users_assigned_to_application(app_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}/users")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def create_app(app_data)
      # app_data should have this schema at minimum
      # see schemas/app.rb for full object
      #app_data = {
        #"name": "template_basic_auth",
        #"label": "Sample Basic Auth App",
        #"signOnMode": "BASIC_AUTH",
        #"settings": {
          #"app": {
            #"url": "https://example.com/login.html",
            #"authURL": "https://example.com/auth.html"
          #}
        #}
      #}
      response = call_with_token('post', APP_API_BASE_PATH, app_data.to_json)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def update_app(app_id, app_data)
      response = call_with_token('put', "#{APP_API_BASE_PATH}/#{app_id}", app_data)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def delete_app(app_id)
      response = call_with_token('delete', "#{APP_API_BASE_PATH}/#{app_id}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def activate_app(app_id)
      response = call_with_token('post', "#{APP_API_BASE_PATH}/#{app_id}/lifecycle/activate")
      "Application with id: #{app_id} activated"
    end

    # Description here
    # @param
    # @return
    def deactivate_app(app_id)
      response = call_with_token('post', "#{APP_API_BASE_PATH}/#{app_id}/lifecycle/deactivate")
      "Application with id: #{app_id} deactivated"
    end

    # AUTH SERVER METHODS

    # Description here
    # @param
    # @return
    def auth_servers
      response = call_with_token('get', AUTH_SERVER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # GROUP METHODS

    # Description here
    # @param
    # @return
    def groups
      response = call_with_token('get', GROUP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def apps_assigned_to_group(group_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=group.id+eq+\"#{group_id}\"")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def assign_group_to_application(app_id, group_id)
      response = call_with_token('put', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def remove_group_from_application(app_id, group_id)
      response = call_with_token('delete', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      "Groud with id: #{group_id} has been removed from application with id: #{app_id}"
    end

    # Description here
    # @param
    # @return
    def get_assigned_group_for_application(app_id,group_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      JSON.parse(response.body)
    end

    # SYSTEM LOG METHODS

    # Description here
    # @param
    # @return
    def logs(time_range:, event:)
      response = call_with_token(
        'get',
        "#{SYSTEM_LOG_API_BASE_PATH}/logs?filter=eventType+eq+%22#{event}%22&since=#{time_range}"
      )
      JSON.parse(response.body)
    end

    # USER METHODS

    # Description here
    # @param
    # @return
    def users
      response = call_with_token('get', USER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def user(user_id)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{user_id}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def user_from_login(login)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{ERB::Util.url_encode(login)}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def create_user(user_profile_data)
      # see user_profile.csv
      # required fields (non-nullable)
      # profile: {
      #   firstName:
      #   lastName:
      #   email:
      #   login:
      #   mobilePhone:
      # }
      response = call_with_token('post', USER_API_BASE_PATH, user_profile_data)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def create_user_in_group(user_profile_data, group_id_array)
      # profile: {
      #   firstName:
      #   lastName:
      #   email:
      #   login:
      #   mobilePhone:
      # }
      # can pass more than one group id to have user created in multiple
      # groupIds: [
      #   "00g1emaKYZTWRYYRRTSK",
      #   "00g1emaKYZTWRYAFTJKK"
      # ]
      body = user_profile_data
      body[:groupIds] = group_id_array
      response = call_with_token('post', USER_API_BASE_PATH, body)
    end

    # Description here
    # @param
    # @return
    def delete_user(user_id)
      response = call_with_token('delete', "#{USER_API_BASE_PATH}/#{user_id}")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def update_user(user_profile_data)
      # any nonnullable fields in profile not included are deleted, pass whole user profile data.
      response = call_with_token('put', "#{USER_API_BASE_PATH}/#{user_id}", user_profile_data)
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def activate_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/activate?sendEmail=false")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def reactivate_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/reactivate")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def deactivate_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/deactivate")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def suspend_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/suspend")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def unsuspend_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/unsuspend")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def unlock_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/unlock")
      JSON.parse(response.body)
    end

    # Description here
    # @param
    # @return
    def apps_assigned_to_user(user_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=user.id+eq+\"#{user_id}\"")
      JSON.parse(response.body)
    end

  end
end
