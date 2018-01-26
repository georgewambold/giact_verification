require 'spec_helper'
require 'net/http'

describe 'external request' do
  it 'posts to GIACT\'s API to authenticate a bank account' do
    stub_giact_requests!
    uri = URI('https://api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx')

    response = (
      Net::HTTP.post_form(uri, {})
    )

    expect(response.code).to eq("200")
  end
end

