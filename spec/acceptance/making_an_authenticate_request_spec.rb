require 'spec_helper'
require 'nori'

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

  describe 'external request' do
    it 'returns a declined response when given the first_name \'Declined\'' do
      set_config!
      stub_giact_requests!
      declined_customer = valid_customer.merge(first_name: 'Declined')

      response = GiactVerification::Authenticate.call(check: valid_check, customer: declined_customer)

      expect(response.parsed_response[:verification_response]).to eq('Declined')

      reset_config!
    end

    it 'returns an error response and an accessible error when given the first_name \'Error\'' do
      set_config!
      stub_giact_requests!
      error_customer = valid_customer.merge(first_name: 'Error')

      response = GiactVerification::Authenticate.call(check: valid_check, customer: error_customer)

      expect(response.parsed_response[:verification_response]).to eq('Error')
      expect(response.parsed_response[:error_message]).to be_a(String)

      reset_config!
    end

    it 'returns a pass response when given a first name that is not \'Error\' or \'Declined\'' do
      set_config!
      stub_giact_requests!
      good_customer = valid_customer.merge(first_name: 'Kent')

      response = GiactVerification::Authenticate.call(check: valid_check, customer: good_customer)

      expect(response.parsed_response[:verification_response]).to eq('Pass')

      reset_config!
    end

  end

  describe 'integration tests' do
    it 'passes parameters from it\'s API to the GIACT API request' do
      set_config!
      stub_giact_requests!
      good_customer = valid_customer.merge(first_name: 'Kent')

      response = GiactVerification::Authenticate.call(check: valid_check, customer: good_customer)
      parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym})
      parsed_request_body = parser.parse(response.raw_request)[:'soap:envelope'][:'soap:body'][:'post_inquiry'][:'inquiry']

      expect(parsed_request_body[:check]).to eq(valid_check)

      expect(parsed_request_body[:customer]).to eq(good_customer)

      reset_config!
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
