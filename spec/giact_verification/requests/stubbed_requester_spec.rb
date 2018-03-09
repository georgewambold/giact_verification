require 'spec_helper'
require 'nori'

describe GiactVerification::StubbedRequester do
  it 'returns a code of 200' do
    body = 'foo'

    response = GiactVerification::StubbedRequester.call(body: body)

    expect(response.code).to eq('200')
  end

  it "returns a body with verification_response: 'Declined' when passed a body with last_name: 'GiactDeclined'" do
    body = request_xml_with(last_name: 'GiactDeclined')

    response = GiactVerification::StubbedRequester.call(body: body)
    parsed_response_body = GiactVerification::ExtractInquiryResult.call(xml: response.body)

    expect(parsed_response_body[:verification_response]).to eq('Declined')
  end

  it "returns a body with verification_response: 'Error' when passed a body with last_name: 'GiactError'" do
    body = request_xml_with(last_name: 'GiactError')

    response = GiactVerification::StubbedRequester.call(body: body)
    parsed_response_body = GiactVerification::ExtractInquiryResult.call(xml: response.body)

    expect(parsed_response_body[:verification_response]).to eq('Error')
  end

  it "returns a body with verification_response: 'Pass' when passed any other last name" do
    body = request_xml_with(last_name: 'Smith')

    response = GiactVerification::StubbedRequester.call(body: body)
    parsed_response_body = GiactVerification::ExtractInquiryResult.call(xml: response.body)

    expect(parsed_response_body[:verification_response]).to eq('Pass')
  end

  def request_xml_with(last_name:)
    <<-XML
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<soap:Body>
    <PostInquiry xmlns="http://api.giact.com/verificationservices/v5">
        <Inquiry>
          <Customer>
            <LastName>#{last_name}</LastName>
          </Customer>
        </Inquiry>
    </PostInquiry>
  </soap:Body>
</soap:Envelope>
    XML
  end
end
