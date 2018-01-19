require "bundler/setup"
require "pry"
require "giact_verification"

def reset_config!
  GiactVerification.instance_variable_set(:@configuration, nil)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end
