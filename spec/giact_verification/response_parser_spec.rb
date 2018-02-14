require 'spec_helper'

describe GiactVerification::ResponseParser do
  context 'response.code == 200 AND response.body contains some string that is not valid GIACT XML' do
    it 'return a status of :failure' do
      response = double('response', code: "200", body: 'some string')
      allow(GiactVerification::GiactXml).to receive(:new)
        .and_return(instance_double(GiactVerification::GiactXml, valid?: false))

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.status).to eq(:failure)
    end

    it 'return a blank hash for the body' do
      response = double('response', code: "200", body: 'some string')
      allow(GiactVerification::GiactXml).to receive(:new)
        .and_return(instance_double(GiactVerification::GiactXml, valid?: false))

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.body).to eq({})
    end
  end

  context 'response.code == 200 AND response.body that is valid GIACT XML' do
    it 'return a status of :success' do
      response = double('response', code: "200", body: '<valid>xml</valid>')
      allow(GiactVerification::GiactXml).to receive(:new)
        .and_return(
          instance_double(GiactVerification::GiactXml, valid?: true, inquiry_result: {foo: 'bar'})
      )

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.status).to eq(:success)
    end

    it 'return a blank hash for the body' do
      response = double('response', code: "200", body: '<valid>xml</valid>')
      allow(GiactVerification::GiactXml).to receive(:new)
        .and_return(
          instance_double(GiactVerification::GiactXml, valid?: true, inquiry_result: {valid: 'xml'})
      )

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.body).to eq({valid: 'xml'})
    end
  end

  context 'response.code != 2**' do
    it 'return a status of :failure' do
      response = double('response', code: "401", body: 'some string')

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.status).to eq(:failure)
    end

    it 'return a blank hash for the body' do
      response = double('response', code: "401", body: 'some string')

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      expect(parsed_response.body).to eq({})
    end
  end
end
