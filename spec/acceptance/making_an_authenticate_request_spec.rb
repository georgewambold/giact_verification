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
    invalid_customer_params = { first_name: nil, last_name: 1234 }
    invalid_check_params    = { routing_number: 'lol', account_number: 1234 }


    expect{
      GiactVerification::Authenticate.call(customer: invalid_customer_params, check: invalid_check_params)
    }.to raise_error(
      GiactVerification::ArgumentError
    )

    reset_config!
  end

  it 'returns a response object when passed valid arguments' do
    GiactVerification.configure do |config|
      config.api_username = 'georgew'
      config.api_password = '98pasdf'
    end
    valid_customer_params = { first_name: 'Kent', last_name: 'beck' }
    valid_check_params    = { routing_number: '123454', account_number: '000011' }

    response = GiactVerification::Authenticate.call(customer: valid_customer_params, check: valid_check_params)

    expect(response).to be_a(GiactVerification::Response)

    reset_config!
  end
end
