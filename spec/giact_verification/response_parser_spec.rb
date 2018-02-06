require 'spec_helper'

describe GiactVerification::ResponseParser do
  context 'the response indicates invalid credentials' do
    it 'raises an error' do
      response = instance_double(Net::HTTPOK, code: 200, body: 'Error Message: Invalid API Credentials')

      expect {
        GiactVerification::ResponseParser.call(response: response)
      }.to raise_error(
        GiactVerification::HTTPError
      )
    end
  end

  context 'the response is successful' do
    it 'returned the parsed xml as a ruby hash' do
      allow(GiactVerification::ExtractInquiryResult).to receive(:call)
        .and_return({response: 'yay'})
      response = instance_double(Net::HTTPOK, code: 200, body: '<response>yay</response>')

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response).to eq({response: 'yay'})
    end
  end

  context 'the response fails with a 401 status code' do
    it 'raises an HTTPError' do
      response = instance_double(Net::HTTPUnauthorized, code: 401, body: '<html><h1>YA GOOFD</h1></html>')

      expect {
       GiactVerification::ResponseParser.call(response: response)
      }.to raise_error(
        GiactVerification::HTTPError
      )
    end
  end
end
