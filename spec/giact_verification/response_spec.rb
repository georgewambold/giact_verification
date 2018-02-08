require 'spec_helper'

describe GiactVerification::Response do

  describe 'attributes' do
    it 'has a raw_response attribute' do
      response = GiactVerification::Response.new(raw_response: 'foo')

      expect(response.raw_response).to eq('foo')
    end

    it 'has a raw_request attribute' do
      response = GiactVerification::Response.new(raw_request: 'asdf')

      expect(response.raw_request).to eq('asdf')
    end

    it 'has a parsed_response attribute' do
      response = GiactVerification::Response.new(parsed_response: 'passed!')

      expect(response.parsed_response).to eq('passed!')
    end
  end
end
