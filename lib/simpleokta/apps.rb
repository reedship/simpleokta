module Simpleokta
  class Client
    module Apps
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
      #     app_data = {
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
    end
  end
end
