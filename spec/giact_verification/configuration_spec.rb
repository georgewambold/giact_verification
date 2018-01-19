require 'spec_helper'

describe Configuration do
  it 'stores an api username' do
    config = Configuration.new

    config.api_username = 'bobmartin'

    expect(config.api_username).to eq('bobmartin')
  end

  it 'stores an api password' do
    config = Configuration.new

    config.api_password = 'cleancoderules'

    expect(config.api_password).to eq('cleancoderules')
  end
end
