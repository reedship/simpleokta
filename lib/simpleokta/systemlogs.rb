module Simpleokta
  class Client
    module SystemLogs
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
    end
  end
end
