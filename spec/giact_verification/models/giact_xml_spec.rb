require 'spec_helper'

describe GiactVerification::GiactXml do
  describe '#valid' do
    it 'calls the validator passed to it' do
      validator = double('validator')
      allow(validator).to receive(:call)

      GiactVerification::GiactXml.new(xml: 'foo', validator: validator).valid?

      expect(validator).to have_received(:call)
    end
  end

  describe '#inquiry_result' do
    it 'raises an error if inquiry_result is called on an instance that is not valid' do
      validator = double('validator')
      allow(validator).to receive(:call)
        .and_return(false)

      expect {
        GiactVerification::GiactXml.new(xml: 'foo', validator: validator).inquiry_result
      }.to raise_error(
        GiactVerification::GiactXmlError, 'Cannot retrieve inquiry result from invalid xml'
      )
    end

    it 'call ExtractInquiryResult if inquiry_result is called on valid instance' do
      validator = double('validator')
      allow(validator).to receive(:call)
        .and_return(true)
      allow(GiactVerification::ExtractInquiryResult).to receive(:call)

      GiactVerification::GiactXml.new(xml: 'foo', validator: validator).inquiry_result

      expect(GiactVerification::ExtractInquiryResult).to have_received(:call)
    end
  end
end
