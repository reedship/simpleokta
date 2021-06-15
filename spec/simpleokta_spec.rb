# frozen_string_literal: true

require 'dotenv'

RSpec.describe Simpleokta::Client do
  describe 'shared context across specs' do
    it 'loads api token from env variables correctly' do
      expect(client.instance_variable_get(:@api_token)).not_to be(nil)
    end
    it 'loads api token from env variables correctly' do
      expect(client.instance_variable_get(:@base_api_url)).not_to be(nil)
    end
  end
end
