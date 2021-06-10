module Simpleokta
  class Client
    module AuthServers
      # AUTH SERVER METHODS

      # Return all Authorization Servers in the okta instance.
      # @return [Array<Authorization Server Object>]
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#authorization-server-object Authorization Server Object
      def auth_servers
        response = call_with_token('get', Constants::AUTH_SERVER_API_BASE_PATH)
        JSON.parse(response.body)
      end
    end

  end
end
