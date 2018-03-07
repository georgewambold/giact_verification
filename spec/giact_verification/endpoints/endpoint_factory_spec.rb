require 'spec_helper'

describe GiactVerification::EndpointFactory do
  describe '.for' do

    it 'returns a production endpoint when given type: :production' do
      endpoint = GiactVerification::EndpointFactory.for(type: :production)

      expect(endpoint).to be_an_instance_of(GiactVerification::ProductionEndpoint)
    end

    it 'returns a sandbox endpoint when given type: :sandbox' do
      endpoint = GiactVerification::EndpointFactory.for(type: :sandbox)

      expect(endpoint).to be_an_instance_of(GiactVerification::SandboxEndpoint)
    end

    it 'returns a stubbed endpoint when given type: :stubbed' do
      endpoint = GiactVerification::EndpointFactory.for(type: :stubbed)

      expect(endpoint).to be_an_instance_of(GiactVerification::StubbedEndpoint)
    end

    it 'returns an error when passed an unknown type' do
      expect{
        endpoint = GiactVerification::EndpointFactory.for(type: :foo2)
      }.to raise_error(GiactVerification::ConfigurationError)
    end
  end
end
