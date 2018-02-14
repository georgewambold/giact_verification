require 'spec_helper'

describe GiactVerification::GiactXmlValidator do
  it 'returns false if passed a non-xml string' do
    string = 'asdf'

    expect(GiactVerification::GiactXmlValidator.call(xml: string)).to eq(false)
  end

  it 'is invalid if passed a xml string that is not in giact format' do
    bad_xml = '<foo>bar</foo>'

    expect(GiactVerification::GiactXmlValidator.call(xml: bad_xml)).to eq(false)
  end

  it 'is valid if passed a giact formatted xml string' do
    expect(GiactVerification::GiactXmlValidator.call(xml: valid_giact_xml)).to eq(true)
  end

  def valid_giact_xml
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
