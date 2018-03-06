require 'bundler/setup'
require 'pry'
require 'giact_verification'
require 'webmock/rspec'
require 'support/fake_giact'
require 'support/fake_sandbox_giact'
require 'yaml'

def set_production_config!
  GiactVerification.configure do |config|
    config.api_username = 'user'
    config.api_password = 'pass'
    config.giact_endpoint = :production
  end
end

def reset_config!
  GiactVerification.instance_variable_set(:@configuration, nil)
end

def stub_production_requests!
  stub_request(:any, /api.giact.com/).to_rack(FakeGiact)
end

def stub_sandbox_requests!
  stub_request(:any, /sandbox.api.giact.com/).to_rack(FakeSandboxGiact)
end
