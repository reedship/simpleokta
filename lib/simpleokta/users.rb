module Simpleokta
  class Client
    module Users
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
end
