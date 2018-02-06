require 'spec_helper'
require 'nori'

describe 'making a giact request' do
  it 'passes check parameters from GiactVerification::Authenticate.call to the GIACT request' do
    set_config!
    stub_giact_requests!

    response = GiactVerification::Authenticate.call(check: full_check, customer: full_customer)
    parser = Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.snakecase.to_sym})
    parsed_request_body = parser.parse(response.raw_request)[:'soap:envelope'][:'soap:body'][:post_inquiry][:inquiry]

    expect(parsed_request_body[:check]).to eq(giact_format_check)

    reset_config!
  end

  it 'passes customer parameters from GiactVerification::Authenticate.call to the GIACT request' do
    set_config!
    stub_giact_requests!

    response = GiactVerification::Authenticate.call(check: full_check, customer: full_customer)
    parser = Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.snakecase.to_sym})
    parsed_request_body = parser.parse(response.raw_request)[:'soap:envelope'][:'soap:body'][:post_inquiry][:inquiry]

    expect(parsed_request_body[:customer]).to eq(giact_format_customer)

    reset_config!
  end

  it 'upcases state and country parameters before they\'re substituted into the GIACT request' do
    set_config!
    stub_giact_requests!

    lowercase_value_customer = full_customer.merge(state: 'ma', country: 'us', drivers_license_state: 'ma')

    response = GiactVerification::Authenticate.call(check: full_check, customer: lowercase_value_customer)
    parser = Nori.new(:advanced_typecasting => false, :convert_tags_to => lambda { |tag| tag.snakecase.to_sym})
    parsed_request_body = parser.parse(response.raw_request)[:'soap:envelope'][:'soap:body'][:post_inquiry][:inquiry]

    expect(parsed_request_body[:customer]).to eq(giact_format_customer)

    reset_config!
  end

  def full_customer
    {
      name_prefix: 'Mr',
      first_name: 'Kent',
      middle_name: 'Spec',
      last_name: 'Beck',
      name_suffix: 'Sr.',
      address_line1: '123 Test Dr.',
      address_line2: 'apt 101',
      city: 'Melrose',
      state: 'MA',
      zip_code: '10023',
      country: 'US',
      phone_number: '1234567890',
      tax_id: '111003333',
      date_of_birth: Date.parse('sept 1 1961'),
      drivers_license_number: 'MC1234567',
      drivers_license_state: 'MA',
      email_address: 'kbeck@you_must.tdd',
      current_ip_address: '1234432',
      alternative_id_type: 'PassportUsa',
      alternative_id_number: '123456789',
      domain: 'testing.first.can.be.fun',
    }
  end

  def giact_format_customer
    {
      name_prefix: 'Mr',
      first_name: 'Kent',
      middle_name: 'Spec',
      last_name: 'Beck',
      name_suffix: 'Sr.',
      address_line1: '123 Test Dr.',
      address_line2: 'apt 101',
      city: 'Melrose',
      state: 'MA',
      zip_code: '10023',
      country: 'US',
      phone_number: '1234567890',
      tax_id: '111003333',
      date_of_birth: '1961-09-01',
      dl_number: 'MC1234567',
      dl_state: 'MA',
      email_address: 'kbeck@you_must.tdd',
      current_ip_address: '1234432',
      alt_id_type: 'PassportUsa',
      alt_id_number: '123456789',
      domain: 'testing.first.can.be.fun',
    }
  end

  def full_check
    {
      routing_number: '123456789',
      account_number: '123000011',
      account_type: 'Checking',
      check_number: 980123,
      check_amount: 100.01,
    }
  end

  def giact_format_check
    {
      routing_number: '123456789',
      account_number: '123000011',
      account_type: 'Checking',
      check_number: '980123',
      check_amount: '100.01',
    }
  end
end
