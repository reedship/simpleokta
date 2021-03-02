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

    # Initialize using passed in config hash
    # @param config [Hash]
    def initialize(config)
      @base_api_url = config.base_api_url
      @api_token = config.api_token
    end


    # Setting initial connection with base_api_url from config
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
    # @return [Array<Application Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def apps
      response = call_with_token('get', APP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Return a specific application in the okta instance.
    # @param app_id [String] the unique id of the application
    # @return [Hash<Application Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def app(app_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}")
      JSON.parse(response.body)
    end

    # Returns all users currently assigned to the application
    # @param app_id [String] the unique id of the application
    # @return [Array<User Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-user-object User Object
    def users_assigned_to_application(app_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}/users")
      JSON.parse(response.body)
    end

    # Creates an application in Okta.
    # @param app_data [Hash] The hash of data you want the application to contain.
    # @see https://developer.okta.com/docs/reference/api/apps/#add-application Add application data.
    # @example
    #   Creating a Basic Auth App
    #     {
    #       "name": "template_basic_auth",
    #       "label": "Sample Basic Auth App",
    #       "signOnMode": "BASIC_AUTH",
    #       "settings": {
    #         "app": {
    #           "url": "https://example.com/login.html",
    #           "authURL": "https://example.com/auth.html"
    #         }
    #       }
    #     }
    # @return [Hash<Application Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def create_app(app_data)
      response = call_with_token('post', APP_API_BASE_PATH, app_data.to_json)
      JSON.parse(response.body)
    end

    # Update an application
    # @param app_id [String] the unique id of the application
    # @param app_data [Hash] The hash of data you want the application to contain.
    #   Pass in all required fields, anything you leave out will be removed from the application on update.
    # @return [Hash<Application Object>] The updated app
    # @see https://developer.okta.com/docs/reference/api/apps/#update-application Update Application
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def update_app(app_id, app_data)
      response = call_with_token('put', "#{APP_API_BASE_PATH}/#{app_id}", app_data)
      JSON.parse(response.body)
    end

    # Delete an application by id
    # @param app_id [String] the unique id of the application
    # @return {}
    def delete_app(app_id)
      response = call_with_token('delete', "#{APP_API_BASE_PATH}/#{app_id}")
      JSON.parse(response.body)
    end

    # Activate an application by id
    # @param app_id [String] the unique id of the application
    # @see https://developer.okta.com/docs/reference/api/apps/#activate-application Activate Application
    # @return {}
    def activate_app(app_id)
      response = call_with_token('post', "#{APP_API_BASE_PATH}/#{app_id}/lifecycle/activate")
      "Application with id: #{app_id} activated"
    end

    # Deactivate an application by id
    # @param app_id [String] the unique id of the application
    # @see https://developer.okta.com/docs/reference/api/apps/#deactivate-application Deactivate Application
    # @return {}
    def deactivate_app(app_id)
      response = call_with_token('post', "#{APP_API_BASE_PATH}/#{app_id}/lifecycle/deactivate")
      "Application with id: #{app_id} deactivated"
    end

    # AUTH SERVER METHODS

    # Return all Authorization Servers in the okta instance.
    # @return [Array<Authorization Server Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
    def auth_servers
      response = call_with_token('get', AUTH_SERVER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # GROUP METHODS

    # Return all Groups in the okta instance.
    # @return [Array<Group Object>]
    # @see https://developer.okta.com/docs/reference/api/groups/#group-object Group Object
    def groups
      response = call_with_token('get', GROUP_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Return all applications members of a group have automatically assigned to them.
    # @param group_id [String] the unique identifier of the group
    # @return [Array<Group Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    def apps_assigned_to_group(group_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=group.id+eq+\"#{group_id}\"")
      JSON.parse(response.body)
    end

    # Set an application to be automatically assigned to members of a group
    # @param app_id [String] the unique id of the application
    # @param group_id [String] the unique identifier of the group
    # @return
    def assign_group_to_application(app_id, group_id)
      response = call_with_token('put', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      JSON.parse(response.body)
    end

    # Set an application to no longer be automatically assigned to members of a group
    # @param app_id [String] the unique id of the application
    # @param group_id [String] the unique identifier of the group
    # @return [Group Assignment]
    # @see https://developer.okta.com/docs/reference/api/apps/#response-example-34 Group Assignment Response
    # @see https://developer.okta.com/docs/reference/api/apps/#assign-group-to-application Assign Group To Application
    def remove_group_from_application(app_id, group_id)
      response = call_with_token('delete', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      "Groud with id: #{group_id} has been removed from application with id: #{app_id}"
    end

    # Returns an application group assignment
    # @param app_id [String] the unique id of the application
    # @param group_id [String] the unique identifier of the group
    # @return [Group Assignment]
    # @see https://developer.okta.com/docs/reference/api/apps/#response-example-34 Group Assignment Response
    def get_assigned_group_for_application(app_id,group_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
      JSON.parse(response.body)
    end

    # SYSTEM LOG METHODS

    # Return all system logs of a specific event, within a certain time range.
    # @param event [String] Okta Event Type
    # @param time_range [String] ISO-8601 Time Stamp
    # @return [Array<LogEvent>]
    # @see https://developer.okta.com/docs/reference/api/system-log/#event-types Event Types
    # @see https://developer.okta.com/docs/reference/api/system-log/#logevent-object LogEvent Object
    def logs(event, time_range)
      response = call_with_token(
        'get',
        "#{SYSTEM_LOG_API_BASE_PATH}/logs?filter=eventType+eq+%22#{event}%22&since=#{time_range}"
      )
      JSON.parse(response.body)
    end

    # USER METHODS

    # Return all users in an okta instance
    # @return [Array<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    def users
      response = call_with_token('get', USER_API_BASE_PATH)
      JSON.parse(response.body)
    end

    # Return a specific user in an okta instance
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    def user(user_id)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{user_id}")
      JSON.parse(response.body)
    end

    # Return a specific user in an okta instance
    # @param login [String] the login email of the user
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    def user_from_login(login)
      response = call_with_token('get', "#{USER_API_BASE_PATH}/#{ERB::Util.url_encode(login)}")
      JSON.parse(response.body)
    end

    # Create a user in the okta instance
    # @param user_profile_data [Hash] the required fields to create a user in okta.
    #   At minimum, this should contain the Profile object.
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#create-user Create User
    # @see https://developer.okta.com/docs/reference/api/users/#profile-object Profile Object
    def create_user(user_profile_data)
      response = call_with_token('post', USER_API_BASE_PATH, user_profile_data)
      JSON.parse(response.body)
    end

    # Create a user in the okta insance, and have the user added to groups
    # @param user_profile_data [Hash] the required fields to create a user in okta.
    #   At minimum, this should contain the Profile object.
    # @param group_id_array [Array<String>] the group ids the user should be added to
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    # @see https://developer.okta.com/docs/reference/api/users/#create-user-in-group Create User in Group
    def create_user_in_group(user_profile_data, group_id_array)
      body = user_profile_data
      body[:groupIds] = group_id_array
      response = call_with_token('post', USER_API_BASE_PATH, body)
    end

    # Delete a user in the okta instance
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    def delete_user(user_id)
      response = call_with_token('delete', "#{USER_API_BASE_PATH}/#{user_id}")
      JSON.parse(response.body)
    end

    # Update a user in the okta instance
    # @param user_profile_data [Hash] the required fields to create a user in okta.
    #   At minimum, this should contain the Profile object.
    #   Any fields not passed in user_profile_data will be set to null in the user data
    # @return [Hash<User>]
    # @see https://developer.okta.com/docs/reference/api/users/#user-object User Object
    def update_user(user_profile_data)
      response = call_with_token('put', "#{USER_API_BASE_PATH}/#{user_id}", user_profile_data)
      JSON.parse(response.body)
    end

    # Activate a user in the okta instance.
    #   Users created are not immediately activated until they log on. This method bypasses that requirement
    # @param user_id [String] the unique id of a user in the okta instance
    # @param send_email [Boolean] whether or not to send an activation email to the user
    # @return [Hash] contains information on activation.
    #   If send_email is set to True, returns an empty hash.
    # @see https://developer.okta.com/docs/reference/api/users/#activate-user Activate User
    def activate_user(user_id, send_email)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/activate?sendEmail=#{send_email.to_s}")
      JSON.parse(response.body)
    end

    # Reactivates a user in the okta instance that was deactivated.
    # @param user_id [String] the unique id of a user in the okta instance
    # @param send_email [Boolean] whether or not to send an activation email to the user
    # @return [Hash] contains information on activation.
    #   If send_email is set to True, returns an empty hash.
    # @see https://developer.okta.com/docs/reference/api/users/#reactivate-user Reactivate User
    def reactivate_user(user_id, send_email)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/reactivate?sendEmail=#{send_email.to_s}")
      JSON.parse(response.body)
    end

    # Deactivates a user in the okta instance.
    # @param user_id [String] the unique id of a user in the okta instance
    # @param send_email [Boolean] whether or not to send an activation email to the user
    # @return [Hash] empty hash
    # @see https://developer.okta.com/docs/reference/api/users/#deactivate-user Deactivate User
    def deactivate_user(user_id, send_email)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/deactivate?sendEmail=#{send_email.to_s}")
      JSON.parse(response.body)
    end

    # Suspend a user in the okta instance.
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Hash] empty hash
    # @see https://developer.okta.com/docs/reference/api/users/#suspend-user Suspend User
    def suspend_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/suspend")
      JSON.parse(response.body)
    end

    # Unsuspend a user in the okta instance.
    #   Sets the user status to ACTIVE.
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Hash] empty hash
    # @see https://developer.okta.com/docs/reference/api/users/#unsuspend-user Unsuspend User
    def unsuspend_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/unsuspend")
      JSON.parse(response.body)
    end

    # Unlocks a user in the okta instance.
    #   Only available when a user has LOCKED_OUT status.
    #   Sets the user status to ACTIVE.
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Hash] empty hash
    # @see https://developer.okta.com/docs/reference/api/users/#unlock-user Unlock User
    def unlock_user(user_id)
      response = call_with_token('post', "#{USER_API_BASE_PATH}/#{user_id}/lifecycle/unlock")
      JSON.parse(response.body)
    end

    # List all applications a user currently has assigned to them.
    # @param user_id [String] the unique id of a user in the okta instance
    # @return [Array<Application Object>]
    # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
    # @see https://developer.okta.com/docs/reference/api/apps/#list-applications-assigned-to-a-user List Applications Assigned to User
    def apps_assigned_to_user(user_id)
      response = call_with_token('get', "#{APP_API_BASE_PATH}/?filter=user.id+eq+\"#{user_id}\"")
      JSON.parse(response.body)
    end

  end
end
