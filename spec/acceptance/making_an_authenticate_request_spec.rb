require 'spec_helper'

describe 'making a gAuthenticate request' do
  context 'without configuring API authentication' do
    it 'raises a configuration error' do
      expect{
        GiactVerification::Authenticate.call(customer: nil, check: nil)
      }.to raise_error(
        GiactVerification::ConfigurationError
      )
    end
  end

  context 'with bad arguments' do
    it 'raises an argument error' do
      GiactVerification.configure do |config|
        config.api_username = 'georgew'
        config.api_password = '98pasdf'
      end

      expect{
        GiactVerification::Authenticate.call(customer: nil, check: nil)
      }.to raise_error(
        GiactVerification::ArgumentError
      )
    end

    reset_config!
  end

  context 'with valid arguments' do
    it 'returns a giact response' do
      GiactVerification.configure do |config|
        config.api_username = 'georgew'
        config.api_password = '98pasdf'
      end
      valid_customer = double('customer', first_name: 'Kent', last_name: 'beck')
      valid_check    = double('check', routing_number: '123454', account_number: '000011')

      response = GiactVerification::Authenticate.call(customer: valid_customer, check: valid_check)

      expect(response).to be_a(GiactVerification::Response)

      reset_config!
    end
  end
end
