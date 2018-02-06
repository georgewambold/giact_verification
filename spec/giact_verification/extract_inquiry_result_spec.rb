require 'spec_helper'

describe GiactVerification::ExtractInquiryResult do
  it 'raises an error if passed a malformed string of xml' do
    xml = '<foo>bar</foo>'

    expect {
      GiactVerification::ExtractInquiryResult.call(xml: xml)
    }.to raise_error(GiactVerification::MalformedXmlError)
  end

  it 'takes a string of XML' do
    inquiry_result = GiactVerification::ExtractInquiryResult.call(xml: xml)

    expect(inquiry_result).to eq({ foo: 'bar' })
  end

  def xml
    <<-XML
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <soap:Body>
    <PostInquiryResponse xmlns="http://api.giact.com/verificationservices/v5">
      <PostInquiryResult>
      <Foo>bar</Foo>
      </PostInquiryResult>
    </PostInquiryResponse>
  </soap:Body>
</soap:Envelope>
    XML
  end
end
