module Simpleokta

  class Configuration
    attr_accessor :api_token, :base_api_url

    def initialize
      @api_token = nil
      @base_api_url = nil
    end
  end

end

