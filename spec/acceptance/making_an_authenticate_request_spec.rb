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

  describe 'external request with mock GIACT server' do
    context 'response code 200' do
      it 'can parse the response' do
        set_config!
        stub_giact_requests!
        declined_customer = valid_customer.merge(first_name: 'Declined')

        response = GiactVerification::Authenticate.call(check: valid_check, customer: declined_customer)

        expect(response.success?).to eq(true)
        expect(response.raw_response).to be_a(String)
        expect(response.raw_request).to be_a(String)
        expect(response.parsed_response[:verification_response]).to eq('Declined')

        reset_config!
      end

      it 'parses an internal GIACT validation error response' do
        set_config!
        stub_giact_requests!
        error_customer = valid_customer.merge(first_name: 'Error')

        response = GiactVerification::Authenticate.call(check: valid_check, customer: error_customer)

        expect(response.success?).to eq(true)
        expect(response.raw_response).to be_a(String)
        expect(response.raw_request).to be_a(String)
        expect(response.parsed_response[:verification_response]).to eq('Error')

        reset_config!
      end

      it 'parses an authentication error in the body' do
        set_config!
        stub_giact_requests!
        error_customer = valid_customer.merge(first_name: 'AuthError')

        response = GiactVerification::Authenticate.call(check: valid_check, customer: error_customer)

        expect(response.success?).to eq(false)
        expect(response.parsed_response).to be_empty

        reset_config!
      end

      it 'parses an unknown error the body' do
        set_config!
        stub_giact_requests!
        error_customer = valid_customer.merge(first_name: 'UnknownError')

        response = GiactVerification::Authenticate.call(check: valid_check, customer: error_customer)

        expect(response.success?).to eq(false)
        expect(response.parsed_response).to be_empty

        reset_config!
      end
    end

    context 'response code not 2XX' do
      it 'can make a request and parse an HTTP 401 error' do
        set_config!
        stub_giact_requests!
        error_customer = valid_customer.merge(first_name: 'Blacklist')

        response = GiactVerification::Authenticate.call(check: valid_check, customer: error_customer)

        expect(response.success?).to eq(false)
        expect(response.parsed_response).to be_empty

        reset_config!
      end
    end
  end

  def valid_customer
    {
      first_name: 'Kent',
      last_name: 'Beck',
      address_line1: '123 Test Dr.',
      city: 'Melrose',
      state: 'MA',
      zip_code: '10023',
      country: 'US',
      phone_number: '1234567890',
      tax_id: '111003333',
      date_of_birth: Date.parse('sept 1 1961'),
      drivers_license_number: 'MC1234567',
      drivers_license_state: 'MA',
    }
  end

  def valid_check
    {
      routing_number: '123456789',
      account_number: '123000011',
      account_type: 'Checking',
    }
  end
end
