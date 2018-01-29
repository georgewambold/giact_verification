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

  describe '#servicing?' do
    it 'returns false for a region that\'s not in the serviced_states config' do
      allow(YAML).to receive(:load_file)
        .and_return( ['FO', 'BA'] )

      expect(Configuration.new.servicing?('IL')).to eq(false)

      reset_config!
    end

    it 'returns true for a region is in the serviced_states config' do
      allow(YAML).to receive(:load_file)
        .and_return( ['FO', 'BA'] )

      expect(Configuration.new.servicing?('FO')).to eq(true)

      reset_config!
    end

    it 'is case sensitive' do
      allow(YAML).to receive(:load_file)
        .and_return( ['FO', 'BA'] )

      expect(Configuration.new.servicing?('fo')).to eq(false)

      reset_config!
    end
  end

  describe '#servicing_country?' do
    it 'returns false for countries not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['USA!BABYYYY!', 'CANADIA'] )

      expect(Configuration.new.servicing_country?('micronesia')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['USA!BABYYYY!', 'CANADIA'] )

      expect(Configuration.new.servicing_country?('CANADIA')).to eq(true)

      reset_config!
    end
  end

  describe '#supports_request_type?' do
    it 'returns false for request types not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['credit_check', 'bank_verify'] )

      expect(Configuration.new.supports_request_type?('foo')).to eq(false)

      reset_config!
    end

    it 'returns true for request types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['credit_check', 'bank_verify'] )

      expect(Configuration.new.supports_request_type?('credit_check')).to eq(true)

      reset_config!
    end
  end

  describe '#accepts_id_type?' do
    it 'returns false for id types not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['passport', 'student_id'] )

      expect(Configuration.new.accepts_id_type?('green_card')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['passport', 'student_id'] )

      expect(Configuration.new.accepts_id_type?('passport')).to eq(true)
    end
  end

  describe '#valid_account_type?' do
    it 'returns false for countries not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['high_yield', 'biz_checking'] )

      expect(Configuration.new.valid_account_type?('401k')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['high_yield', 'biz_checking'] )

      expect(Configuration.new.valid_account_type?('high_yield')).to eq(true)

      reset_config!
    end
  end
end
