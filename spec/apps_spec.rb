require 'vcr'
require 'simpleokta/apps'

RSpec.describe Simpleokta::Client::Apps do
  it "returns a list of applications" do
    response = client.apps
    expect(response.body).not_to be(nil)
  end
end

