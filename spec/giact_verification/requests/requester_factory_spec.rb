require 'spec_helper'

describe GiactVerification::RequesterFactory do
  describe ".call" do
    it 'returns Request if the giact_endpoint is set as :production' do
      allow(GiactVerification).to receive(:giact_endpoint)
        .and_return(:production)

      requester = GiactVerification::RequesterFactory.call

      expect(requester).to eq(GiactVerification::ProductionRequester)
    end

    it 'returns Request if the giact_endpoint is set as :sandbox' do
      allow(GiactVerification).to receive(:giact_endpoint)
        .and_return(:sandbox)

      requester = GiactVerification::RequesterFactory.call

      expect(requester).to eq(GiactVerification::SandboxRequester)
    end

    it 'returns StubbedRequest if the giact_endpoint is set as :stubbed' do
      allow(GiactVerification).to receive(:giact_endpoint)
        .and_return(:stubbed)

      requester = GiactVerification::RequesterFactory.call

      expect(requester).to eq(GiactVerification::StubbedRequester)
    end
  end
end
