require 'spec_helper'

describe 'configuring the gem' do
  it 'allows configuration to be added to the gem' do
    GiactVerification.configure do |config|
      config.api_username = 'smetz'
      config.api_password = 'bikes4life'
      config.sandbox_mode = true
      config.giact_uri    = 'www.giact.sandbox.com'
    end

    expect(GiactVerification.configuration.api_username).to eq('smetz')
    expect(GiactVerification.configuration.api_password).to eq('bikes4life')
    expect(GiactVerification.configuration.sandbox_mode).to eq(true)
    expect(GiactVerification.configuration.giact_uri).to eq('www.giact.sandbox.com')

    reset_config!
  end
end
