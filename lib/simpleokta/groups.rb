module Simpleokta
  class Client
    module Groups
      # GROUP METHODS

      # Return a specific Group in the okta instance.
      # @return [Hash<Group Object>]
      # @param group_id [String] the unique identifier of the group
      # @see https://developer.okta.com/docs/reference/api/groups/#group-object Group Object
      def group(group_id)
        response = call_with_token('get', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}")
        JSON.parse(response.body)
      end

      # Return all Groups in the okta instance.
      # @return [Array<Group Object>]
      # @see https://developer.okta.com/docs/reference/api/groups/#group-object Group Object
      def groups
        response = call_with_token('get', Constants::GROUP_API_BASE_PATH)
        JSON.parse(response.body)
      end

      # Return all applications members of a group have automatically assigned to them.
      # @param group_id [String] the unique identifier of the group
      # @return [Array<Group Object>]
      # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
      def apps_assigned_to_group(group_id)
        response = call_with_token('get', "#{Constants::APP_API_BASE_PATH}/?filter=group.id+eq+\"#{group_id}\"")
        JSON.parse(response.body)
      end

      # Set an application to be automatically assigned to members of a group
      # @param app_id [String] the unique id of the application
      # @param group_id [String] the unique identifier of the group
      # @return
      def assign_group_to_application(app_id, group_id)
        response = call_with_token('put', "#{Constants::APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
        JSON.parse(response.body)
      end

      # Set an application to no longer be automatically assigned to members of a group
      # @param app_id [String] the unique id of the application
      # @param group_id [String] the unique identifier of the group
      # @return [Group Assignment]
      # @see https://developer.okta.com/docs/reference/api/apps/#response-example-34 Group Assignment Response
      # @see https://developer.okta.com/docs/reference/api/apps/#assign-group-to-application Assign Group To Application
      def remove_group_from_application(app_id, group_id)
        response = call_with_token('delete', "#{Constants::APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
        "Groud with id: #{group_id} has been removed from application with id: #{app_id}"
      end

      # Returns an application group assignment
      # @param app_id [String] the unique id of the application
      # @param group_id [String] the unique identifier of the group
      # @return [Group Assignment]
      # @see https://developer.okta.com/docs/reference/api/apps/#response-example-34 Group Assignment Response
      def get_assigned_group_for_application(app_id,group_id)
        response = call_with_token('get', "#{Constants::APP_API_BASE_PATH}/#{app_id}/groups/#{group_id}")
        JSON.parse(response.body)
      end

      # Update a group in the okta instance.
      # @param group_id [String] the unique identifier of the group
      # @param group_data [Hash] the data you want the group to contain
      # @return [Hash<Group Object>]
      # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
      # @see https://developer.okta.com/docs/reference/api/groups/#update-group Update Group
      def update_group(group_id, group_data)
        response = call_with_token('put', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}", group_data)
        JSON.parse(response.body)
      end

      # Remove a group from your org.
      # @param group_id [String] the unique identifier of the group
      # @return 204 No Content
      # @see https://developer.okta.com/docs/reference/api/apps/#application-object Application Object
      # @see https://developer.okta.com/docs/reference/api/groups/#remove-group Remove Group
      def remove_group(group_id)
        response = call_with_token('delete', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}")
        JSON.parse(response.body)
      end

      #TODO
      def group_members(group_id)
        response = call_with_token('get', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}/users")
        JSON.parse(response.body)
      end

      #TODO
      def add_user_to_group(group_id, user_id)
        response = call_with_token('put', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}/users/#{user_id}")
        JSON.parse(response.body)
      end

      #TODO
      def remove_user_from_group(group_id, user_id)
        response = call_with_token('delete', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}/users/#{user_id}")
        JSON.parse(response.body)
      end

      # GROUP RULE METHODS

      #TODO: Add return types to these methods

      # Create a new group rule
      # @param group_id [String] the unique identifier of the group
      # @param rule_data [Hash<Rule Object>] the data for the rule
      # @see https://developer.okta.com/docs/reference/api/groups/#create-group-rule Create Group Rule
      # @see  https://developer.okta.com/docs/reference/api/groups/#rule-object Rule Object
      def create_group_rule(group_id, rule_data)
        response = call_with_token('post', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}/users/#{user_id}")
        JSON.parse(response.body)
      end


      # Update a group rule
      # @param group_id [String] the unique identifier of the group
      # @param rule_id [String] the id for the rule
      # @see https://developer.okta.com/docs/reference/api/groups/#update-group-rule Update Group Rule
      def update_group_rule(group_id, rule_data)
        response = call_with_token('put', "#{Constants::GROUP_API_BASE_PATH}/#{group_id}/users/#{user_id}")
        JSON.parse(response.body)
      end

      # List all group rules in the okta instance
      # @see https://developer.okta.com/docs/reference/api/groups/#list-group-rules List Group Rules
      def group_rules
        response = call_with_token('get' "#{Constants::GROUP_API_BASE_PATH}/rules")
        JSON.parse(response.body)
      end

      # List a specific group rule in the okta instance
      # @param rule_id [String] the id for the rule
      # @return  [Hash<Rule Object>]
      # @see https://developer.okta.com/docs/reference/api/groups/#get-group-rule Get Group Rule
      def group_rule(rule_id)
        response = call_with_token('get' "#{Constants::GROUP_API_BASE_PATH}/rules/#{rule_id}")
        JSON.parse(response.body)
      end

      # Delete a specific group rule in the okta instance
      # @param rule_id [String] the id for the rule
      # @return 202 Accepted
      # @see https://developer.okta.com/docs/reference/api/groups/#delete-a-group-rule Delete Group Rule
      def delete_group_rule(rule_id)
        response = call_with_token('delete' "#{Constants::GROUP_API_BASE_PATH}/rules/#{rule_id}")
        JSON.parse(response.body)
      end
    end
  end
end
