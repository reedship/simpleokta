require 'dotenv'

RSpec.describe Simpleokta::Util do
  # TODO: put these ENV variables into dotenv file and access that way, these tests are just for my own piece of mind anyway
  let(:util) do
    config = Simpleokta::Configuration.new
    config.api_token = ENV['API_TOKEN']
    config.base_api_url = ENV['BASE_API_URL']
    @util = Simpleokta::Util.new(config)
  end

  it "does something useful" do
    expect(util.instance_variable_get(:@api_token)).to eq(true)
  end
end
