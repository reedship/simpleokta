class Simpleokta
  class Client
    module Groups
      include Constants
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
    end

  end
end
