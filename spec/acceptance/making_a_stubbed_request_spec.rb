require 'spec_helper'

describe 'making a stubbed request' do
  it 'can make a successful request' do
    GiactVerification.configure do |config|
      config.api_username = 'foo'
      config.api_password = 'bar'
      config.giact_endpoint = :stubbed
    end
    declined_customer = valid_customer.merge(last_name: 'GiactDeclined')

    response = GiactVerification::Authenticate.call(
      customer: declined_customer,
      check: valid_check
    )

    expect(response.parsed_response[:verification_response]).to eq('Declined')

    reset_config!
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
