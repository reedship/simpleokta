require "bundler/setup"
require "simpleokta"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    Simpleokta.configure do |config|
      config.api_token = ENV['API_TOKEN']
      config.base_api_url = ENV['BASE_API_URL']
    end
  end
end
