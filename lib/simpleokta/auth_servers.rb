# frozen_string_literal: true

module Simpleokta
  class Client
    module AuthServers
      # AUTH SERVER METHODS

      # Get an Authorization Server in the okta instance.
      # @param auth_server_id [String] The unique id of the authorization server
      # @return [Hash<Authorization Server Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
      def auth_server(auth_server_id)
        response = call_with_token(
          'get',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}"
        )
        JSON.parse(response.body)
      end

      # Return all Authorization Servers in the okta instance.
      # @return [Array<Authorization Server Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
      def auth_servers
        response = call_with_token(
          'get',
          Constants::AUTH_SERVER_API_BASE_PATH
        )
        JSON.parse(response.body)
      end

      # Create an Authorization Server in the okta instance.
      # @param auth_server_data [Hash] The Authorization Server Object you want to create
      # @return [Hash<Authorization Server Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-authorization-server Create Authorization Server
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
      def create_auth_server(auth_server_data)
        response = call_with_token(
          'post',
          Constants::AUTH_SERVER_API_BASE_PATH,
          auth_server_data
        )
        JSON.parse(response.body)
      end

      # Update an Authorization Server in the okta instance.
      # @param auth_server_id [String] The unique id of the authorization server
      # @param auth_server_data [Hash] The Authorization Server Object you want to update
      # @return [Hash<Authorization Server Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-authorization-server Update Authorization Server
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
      def update_auth_server(auth_server_id, auth_server_data)
        response = call_with_token(
          'put',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}",
          auth_server_data
        )
        JSON.parse(response.body)
      end

      # Delete an Authorization Server in the okta instance.
      # @param auth_server_id [String] the unique id of the authorization server
      # @return 204 No Content
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-authorization-server Delete Authorization Server
      def delete_auth_server(auth_server_id)
        call_with_token(
          'delete',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}"
        )
      end

      # Activate an Authorization Server in the okta instance.
      # @param auth_server_id [String] the unique id of the authorization server
      # @return 204 No Content
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#activate-authorization-server Activate Authorization Server
      def activate_auth_server(auth_server_id)
        call_with_token(
          'post',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/lifecycle/activate"
        )
      end

      # Deactivate an Authorization Server in the okta instance.
      # @param auth_server_id [String] the unique id of the authorization server
      # @return 204 No Content
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#activate-authorization-server Deactivate Authorization Server
      def deactivate_auth_server(auth_server_id)
        call_with_token(
          'post',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/lifecycle/deactivate"
        )
      end

      # POLICY METHODS

      # Return all Policies attached to a given Authorization Server in the okta instance.
      # @param auth_server_id [String] the unique id of the authorization server
      # @return [Array<Policy Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#policy-object Policy Object
      def policies(auth_server_id)
        response = call_with_token(
          'get',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies"
        )
        JSON.parse(response.body)
      end

      # Return a specific Policy for a given Authorization Server in the okta instance.
      # @param auth_server_id [String] the unique id of the authorization server
      # @param policy_id [String] the unique id of the policy
      # @return [Hash<Policy Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#policy-object Policy Object
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-a-policy Get Policy
      def policy(auth_server_id, _policy_id)
        response = call_with_token(
          'get',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies"
        )
        JSON.parse(response.body)
      end

      # Create a Policy for a given Authorization Server
      # @param auth_server_id [String] the unique id of the authorization server
      # @param policy_data [Hash<Policy Object>] the data for the expected Policy
      # @return [Hash<Policy Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#policy-object Policy Object
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-a-policy Create Policy
      def create_policy(auth_server_id, policy_data)
        response = call_with_token(
          'post',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies",
          policy_data
        )
        JSON.parse(response.body)
      end

      # Update a Policy for a given Authorization Server
      # @param auth_server_id [String] the unique id of the authorization server
      # @param policy_id [String] the unique id of the policy
      # @param policy_data [Hash<Policy Object>] the new data for the Policy
      # @return [Hash<Policy Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#policy-object Policy Object
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-a-policy Update Policy
      def update_policy(auth_server_id, policy_id, policy_data)
        response = call_with_token(
          'put',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}",
          policy_data
        )
        JSON.parse(response.body)
      end

      # Delete a Policy for a given Authorization Server
      # @param auth_server_id [String] the unique id of the authorization server
      # @param policy_id [String] the unique id of the policy
      # @return 204 No Content
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#policy-object Policy Object
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-a-policy Delete Policy
      def delete_policy(auth_server_id, policy_id)
        call_with_token(
          'delete',
          "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}"
        )
      end
    end

    # POLICY RULE METHODS

    # Get all Policy Rules for a given Policy on a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param policy_id [String] the unique id of the policy
    # @return [Array<Rule Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#rule-object Rule object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-policy-rules Get All Policy Rules
    def rules(auth_server_id, policy_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}/rules"
      )
      JSON.parse(response.body)
    end

    # Get a specific Policy Rule for a given Policy on a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param policy_id [String] the unique id of the policy
    # @param rule_id [String] the unique id of the rule
    # @return [Hash<Rule Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#rule-object Rule object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-a-policy-rule Get Policy Rule
    def rule(auth_server_id, policy_id, rule_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}/rules/#{rule_id}"
      )
      JSON.parse(response.body)
    end

    # Create a Policy Rule for a given Policy on a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param policy_id [String] the unique id of the policy
    # @param rule_data [Hash] the rule object you want to create
    # @return [Hash<Rule Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#rule-object Rule object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-a-policy-rule Create Policy Rule
    def create_rule(auth_server_id, policy_id, rule_data)
      response = call_with_token(
        'post',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}/rules",
        rule_data
      )
      JSON.parse(response.body)
    end

    # Update a Policy Rule for a given Policy on a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param policy_id [String] the unique id of the policy
    # @param rule_id [String] the unique id of the rule
    # @param rule_data [Hash] the rule object you want to update
    # @return [Hash<Rule Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#rule-object Rule object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-a-policy-rule Update Policy Rule
    def update_rule(auth_server_id, policy_id, rule_id, rule_data)
      response = call_with_token(
        'put',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}/rules/#{rule_id}",
        rule_data
      )
      JSON.parse(response.body)
    end

    # Delete a Policy Rule for a given Policy on a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param policy_id [String] the unique id of the policy
    # @param rule_id [String] the unique id of the rule
    # @return 204 No Content
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#rule-object Rule object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-a-policy-rule Delete Policy Rule
    def delete_rule(auth_server_id, policy_id, rule_id)
      call_with_token(
        'delete',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/policies/#{policy_id}/rules/#{rule_id}"
      )
    end

    # SCOPES METHODS

    # Get all Scopes defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @return [Array<Scope Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#scope-object Scope Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-scopes Get Scopes
    def scopes(auth_server_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/scopes"
      )
      JSON.parse(response.body)
    end

    # Get a specific Scope defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param scope_id [String] the unique id of the scope
    # @return [Hash<Scope Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#scope-object Scope Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-a-scope Get Scopes
    def scope(auth_server_id, scope_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/scopes/#{scope_id}"
      )
      JSON.parse(response.body)
    end

    # Create a Scope for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param scope_data [Hash<Scope Object>] the data of the scope you wish to create
    # @return [Hash<Scope Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#scope-object Scope Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-a-scope Create Scope
    def create_scope(auth_server_id, scope_data)
      response = call_with_token(
        'post',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/scopes",
        scope_data
      )
      JSON.parse(response.body)
    end

    # Update a Scope for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param scope_id [String] the unique id of the scope
    # @param scope_data [Hash<Scope Object>] the data of the scope you wish to update
    # @return [Hash<Scope Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#scope-object Scope Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-a-scope Create Scope
    def update_scope(auth_server_id, scope_id, scope_data)
      response = call_with_token(
        'put',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/scopes/#{scope_id}",
        scope_data
      )
      JSON.parse(response.body)
    end

    # Delete a Scope for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param scope_id [String] the unique id of the scope
    # @return 204 No Content
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#scope-object Scope Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-a-scope Delete Scope
    def delete_scope(auth_server_id, scope_id)
      call_with_token(
        'delete',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/scopes/#{scope_id}"
      )
    end

    # CLAIMS METHODS

    # Get all Claims defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @return [Array<Claim Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#claim-object Claim Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-claims Get Claims
    def claims(auth_server_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/claims"
      )
      JSON.parse(response.body)
    end

    # Get a specific Claim defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param claim_id [String] the unique id of the claim
    # @return [Hash<Claim Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#claim-object Claim Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-a-claim Get Claim
    def claim(auth_server_id, claim_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/claims/#{claim_id}"
      )
      JSON.parse(response.body)
    end

    # Create a Claim for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param claim_data [Hash<Claim_Object>] the data of the claim you wish to create
    # @return [Hash<Claim Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#claim-object Claim Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-a-claim Create Claim
    def create_claim(auth_server_id, claim_data)
      response = call_with_token(
        'post',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/claims",
        claim_data
      )
      JSON.parse(response.body)
    end

    # Update a specific Claim defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param claim_id [String] the unique id of the claim
    # @param claim_data [Hash<Claim_Object>] the data of the claim you wish to create
    # @return [Hash<Claim Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#claim-object Claim Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-a-claim Update Claim
    def update_claim(auth_server_id, claim_id, claim_data)
      response = call_with_token(
        'put',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/claims/#{claim_id}",
        claim_data
      )
      JSON.parse(response.body)
    end

    # Delete a specific Claim defined for a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @param claim_id [String] the unique id of the claim
    # @return 204 No Content
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#claim-object Claim Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-a-claim Delete Claim
    def delete_claim(auth_server_id, claim_id)
      call_with_token(
        'delete',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/claims/#{claim_id}"
      )
    end

    # KEY STORE OPERATIONS

    # Get all Keys associated with a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @return [Array<Credentials Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#credentials-object Credentials Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-claims Get Authorization Server Keys
    def keys(auth_server_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/credentials/keys"
      )
      JSON.parse(response.body)
    end

    # Rotate the current Keys associated with a given Authorization Server
    # @param auth_server_id [String] the unique id of the authorization server
    # @return [Array<Credentials Object>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#credentials-object Credentials Object
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-claims Rotate Authorization Server Keys
    def rotate_keys(auth_server_id)
      response = call_with_token(
        'post',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/credentials/lifecycle/keyRotate",
        { 'use': 'sig' }
      )
      JSON.parse(response.body)
    end

    # CLIENT RESOURCE OPERATIONS

    # Lists all Client Resources for which the specified Authorization Server has tokens
    # @param auth_server_id [String] the unique id of the authorization server
    # @return [Array<Hash>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#list-client-resources-for-an-authorization-server List Client Resources for an Authorization Server
    def client_resources(auth_server_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/clients"
      )
      JSON.parse(response.body)
    end

    # OAUTH 2.0 TOKEN MGMT OPERATIONS

    # Lists all Refresh Tokens issued by an Authorization Server for a specific client
    # @param auth_server_id [String] the unique id of the authorization server
    # @param client_id [String] the unique id of the client
    # @return [Array<Hash>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#list-refresh-tokens List Refresh Tokens
    def refresh_tokens(auth_server_id, client_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/clients/#{client_id}/tokens"
      )
      JSON.parse(response.body)
    end

    # Gets a specific Refresh Token issued by an Authorization Server for a specific client
    # @param auth_server_id [String] the unique id of the authorization server
    # @param client_id [String] the unique id of the client
    # @param token_id [String] the unique id of the refresh token
    # @return [Array<Hash>]
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-refresh-token Get Refresh Tokens
    def refresh_token(auth_server_id, client_id, token_id)
      response = call_with_token(
        'get',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/clients/#{client_id}/tokens/#{token_id}"
      )
      JSON.parse(response.body)
    end

    # Revokes all Refresh Tokens issued by an Authorization Server for a specific client
    # @param auth_server_id [String] the unique id of the authorization server
    # @param client_id [String] the unique id of the client
    # @return 204 No Content
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#revoke-all-refresh-tokens Revoke Refresh Tokens
    def revoke_refresh_tokens(auth_server_id, client_id)
      response = call_with_token(
        'delete',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/clients/#{client_id}/tokens/#{token_id}"
      )
      JSON.parse(response.body)
    end

    # Revokes a specific Refresh Token issued by an Authorization Server for a specific client
    # @param auth_server_id [String] the unique id of the authorization server
    # @param client_id [String] the unique id of the client
    # @param token_id [String] the unique id of the refresh token
    # @return 204 No Content
    # @see https://developer.okta.com/docs/reference/api/authorization-servers/#revoke-refresh-token Revoke Refresh Token
    def revoke_refresh_token(auth_server_id, client_id, token_id)
      response = call_with_token(
        'delete',
        "#{Constants::AUTH_SERVER_API_BASE_PATH}/#{auth_server_id}/clients/#{client_id}/tokens/#{token_id}"
      )
      JSON.parse(response.body)
    end
  end
end
