require 'dotenv'

RSpec.describe Simpleokta::Client do
  it "does something useful" do
    expect(client.instance_variable_get(:@api_token)).not_to be(nil)
  end
end
