require 'spec_helper'

describe GiactVerification::ResponseParser do
  context 'the response indicates invalid credentials' do
    it 'raises an error' do
      response = instance_double(Net::HTTPOK, body: 'Error Message: Invalid API Credentials')

      expect {
        GiactVerification::ResponseParser.call(response: response)
      }.to raise_error(GiactVerification::HTTPError)
    end
  end

  context 'the response is successful' do
    it 'returned the parsed xml as a ruby hash' do
      allow(GiactVerification::ExtractInquiryResult).to receive(:call)
        .and_return({response: 'yay'})
      response = instance_double(Net::HTTPOK, body: '<response>yay</response>')

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response).to eq({response: 'yay'})
    end
  end
end
