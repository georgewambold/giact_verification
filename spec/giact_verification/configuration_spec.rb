require 'spec_helper'

describe Configuration do
  it 'stores an api username' do
    config = Configuration.new

    config.api_username = 'bobmartin'

    expect(config.api_username).to eq('bobmartin')

    reset_config!
  end

  it 'stores an api password' do
    config = Configuration.new

    config.api_password = 'cleancoderules'

    expect(config.api_password).to eq('cleancoderules')

    reset_config!
  end

  describe '#invalid?' do
    it 'is invalid if it has a api_username and api_password' do
      config = Configuration.new

      expect(config.invalid?).to eq(true)
    end

    it 'is invalid if it has a api_username and api_password' do
      config = Configuration.new

      config.api_username = 'DNeil'
      config.api_password = 'homerow'

      expect(config.invalid?).to eq(false)

      reset_config!
    end
  end
end
