require 'spec_helper'

describe 'making a gAuthenticate request' do
  it 'raises a configuration error if we make a request without configuring the gem with API keys' do
    expect{
      GiactVerification::Authenticate.call(customer: nil, check: nil)
    }.to raise_error(
      GiactVerification::ConfigurationError
    )
  end

  it 'raises an argument error if we pass bad arguments to authenticate' do
    GiactVerification.configure do |config|
      config.api_username = 'georgew'
      config.api_password = '98pasdf'
    end
    invalid_customer_params = { }
    invalid_check_params    = { }


    expect{
      GiactVerification::Authenticate.call(customer: invalid_customer_params, check: invalid_check_params)
    }.to raise_error(
      GiactVerification::ArgumentError
    )

    reset_config!
  end

  context 'unsuccessful' do
    xit 'raises an error when the api request fails' do
      GiactVerification.configure do |config|
        config.api_username = 'georgew'
        config.api_password = '98pasdf'
      end
      valid_check_params = {
        routing_number: '123456789',
        account_number: '000011',
      }
      valid_customer_params = {
        first_name: 'Bad',
        last_name: 'Request',
        address_line_1: '123 Test Dr.',
        city: 'Melrose',
        state: 'MA',
        zip_code: '10023',
        phone_number: '1234567890',
        tax_id: '111003333',
        date_of_birth: Date.parse('sept 1 1961'),
        drivers_license_number: 'MC1234567',
        drivers_license_state: 'MA',
      }

      expect {
        response = GiactVerification::Authenticate.call(customer: valid_customer_params, check: valid_check_params)
      }.to raise_error(GiactVerification::ApiError)

      reset_config!
    end
  end

  context 'successful' do
    it 'returns a response object when passed valid arguments' do
      GiactVerification.configure do |config|
        config.api_username = 'georgew'
        config.api_password = '98pasdf'
      end
      valid_check_params = {
        routing_number: '123456789',
        account_number: '000011',
      }
      valid_customer_params = {
        first_name: 'Kent',
        last_name: 'Beck',
        address_line_1: '123 Test Dr.',
        city: 'Melrose',
        state: 'MA',
        zip_code: '10023',
        phone_number: '1234567890',
        tax_id: '111003333',
        date_of_birth: Date.parse('sept 1 1961'),
        drivers_license_number: 'MC1234567',
        drivers_license_state: 'MA',
      }

      response = GiactVerification::Authenticate.call(customer: valid_customer_params, check: valid_check_params)

      expect(response.body).to eq({ verification_response: 'pass', customer_response_code: 'CA11' })

      reset_config!
    end
  end
end
