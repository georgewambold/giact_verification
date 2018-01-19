require 'spec_helper'

describe 'configuring the gem' do
  it 'allows configuration to be added to the gem' do
    GiactVerification.configure do |config|
      config.api_username = 'smetz'
      config.api_password = 'bikes4life'
    end

    expect(GiactVerification.configuration.api_username).to eq('smetz')
    expect(GiactVerification.configuration.api_password).to eq('bikes4life')
  end
end
