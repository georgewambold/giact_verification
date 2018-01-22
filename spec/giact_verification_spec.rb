require "spec_helper"

RSpec.describe GiactVerification do
  it "has a version number" do
    expect(GiactVerification::VERSION).not_to be nil
  end

  describe '.servicing?' do
    it 'returns false for a region that\'s not in the serviced_states config' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, serviced_states: ['FO', 'BA']))

      expect(GiactVerification.servicing?('IL')).to eq(false)
    end

    it 'returns true for a region is in the serviced_states config' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, serviced_states: ['FO', 'BA']))

      expect(GiactVerification.servicing?('FO')).to eq(true)
    end

    it 'is case sensitive' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, serviced_states: ['FO', 'BA']))

      expect(GiactVerification.servicing?('fo')).to eq(false)
    end
  end

  describe '.servicing_country?' do
    it 'returns false for countries not in the configuration' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, serviced_countries: ['USA!BABYYYY!', 'CANADIA']))

      expect(GiactVerification.servicing_country?('micronesia')).to eq(false)
    end

    it 'returns true for id types in the configuration' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, serviced_countries: ['USA!BABYYYY!', 'CANADIA']))

      expect(GiactVerification.servicing_country?('CANADIA')).to eq(true)
    end
  end

  describe '.accepts_id_type?' do
    it 'returns false for id types not in the configuration' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, valid_alternative_id_types: ['passport', 'student_id']))

      expect(GiactVerification.accepts_id_type?('green_card')).to eq(false)
    end

    it 'returns true for id types in the configuration' do
      allow(GiactVerification).to receive(:configuration)
        .and_return(instance_double(Configuration, valid_alternative_id_types: ['passport', 'student_id']))

      expect(GiactVerification.accepts_id_type?('passport')).to eq(true)
    end
  end
end
