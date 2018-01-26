require 'bundler/setup'
require 'pry'
require 'giact_verification'
require 'webmock/rspec'
require 'support/fake_giact'

def reset_config!
  GiactVerification.instance_variable_set(:@configuration, nil)
end

def stub_giact_requests!
  stub_request(:any, /api.giact.com/).to_rack(FakeGiact)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
end
