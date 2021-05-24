module Simpleokta
  class Client
    module Constants
      API_BASE_PATH = '/api/v1'
      USER_API_BASE_PATH = "#{API_BASE_PATH}/users"
      APP_API_BASE_PATH = "#{API_BASE_PATH}/apps"
      AUTH_SERVER_API_BASE_PATH = "#{API_BASE_PATH}/authorizationServers"
      GROUP_API_BASE_PATH = "#{API_BASE_PATH}/groups"
      SYSTEM_LOG_API_BASE_PATH = "#{API_BASE_PATH}/logs"
      ORG_API_BASE_PATH = "#{API_BASE_PATH}/org"
    end
  end
end
