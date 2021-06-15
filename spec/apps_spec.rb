require 'vcr'
require 'simpleokta/apps'

RSpec.describe Simpleokta::Client::Apps do
  it "returns a list of applications" do
    VCR.use_cassette('apps/all_apps') do
      response = client.apps
      expect(response).not_to be(nil)
    end
  end
end

