require 'spec_helper'

describe GiactVerification::Configuration do
  it 'stores an api username' do
    config = GiactVerification::Configuration.new

    config.api_username = 'bobmartin'

    expect(config.api_username).to eq('bobmartin')

    reset_config!
  end

  it 'stores an api password' do
    config = GiactVerification::Configuration.new

    config.api_password = 'cleancoderules'

    expect(config.api_password).to eq('cleancoderules')

    reset_config!
  end

  describe 'giact_endpoint' do
    it 'defaults the giact_endpoint attribute to :production' do
      config = GiactVerification::Configuration.new

      expect(config.giact_endpoint).to eq(:production)

      reset_config!
    end

    it 'is a settable attribute' do
      config = GiactVerification::Configuration.new

      config.giact_endpoint = :sandbox

      expect(config.giact_endpoint).to eq(:sandbox)

      reset_config!
    end
  end

  describe '#invalid?' do
    it 'is invalid if it has a api_username and api_password' do
      config = GiactVerification::Configuration.new

      expect(config.invalid?).to eq(true)
    end

    it 'is invalid if it has a api_username and api_password' do
      config = GiactVerification::Configuration.new

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

      expect(GiactVerification::Configuration.new.servicing?('IL')).to eq(false)

      reset_config!
    end

    it 'returns true for a region is in the serviced_states config' do
      allow(YAML).to receive(:load_file)
        .and_return( ['FO', 'BA'] )

      expect(GiactVerification::Configuration.new.servicing?('FO')).to eq(true)

      reset_config!
    end

    it 'is case sensitive' do
      allow(YAML).to receive(:load_file)
        .and_return( ['FO', 'BA'] )

      expect(GiactVerification::Configuration.new.servicing?('fo')).to eq(false)

      reset_config!
    end
  end

  describe '#servicing_country?' do
    it 'returns false for countries not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['USA!BABYYYY!', 'CANADIA'] )

      expect(GiactVerification::Configuration.new.servicing_country?('micronesia')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['USA!BABYYYY!', 'CANADIA'] )

      expect(GiactVerification::Configuration.new.servicing_country?('CANADIA')).to eq(true)

      reset_config!
    end
  end

  describe '#accepts_id_type?' do
    it 'returns false for id types not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['passport', 'student_id'] )

      expect(GiactVerification::Configuration.new.accepts_id_type?('green_card')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['passport', 'student_id'] )

      expect(GiactVerification::Configuration.new.accepts_id_type?('passport')).to eq(true)
    end
  end

  describe '#valid_account_type?' do
    it 'returns false for countries not in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['high_yield', 'biz_checking'] )

      expect(GiactVerification::Configuration.new.valid_account_type?('401k')).to eq(false)

      reset_config!
    end

    it 'returns true for id types in the configuration' do
      allow(YAML).to receive(:load_file)
        .and_return( ['high_yield', 'biz_checking'] )

      expect(GiactVerification::Configuration.new.valid_account_type?('high_yield')).to eq(true)

      reset_config!
    end
  end
end
