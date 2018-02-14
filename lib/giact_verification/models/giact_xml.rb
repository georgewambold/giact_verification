module GiactVerification
  class GiactXml

    def initialize(args)
      @xml = args[:xml]
      @validator = args[:validator] || GiactVerification::GiactXmlValidator
    end

    def valid?
      @valid ||= validator.call(xml: xml)
    end

    def inquiry_result
      if invalid?
        raise GiactVerification::GiactXmlError, 'Cannot retrieve inquiry result from invalid xml'
      else
        @inquiry_result ||= GiactVerification::ExtractInquiryResult.call(xml: xml)
      end
    end

    private
    attr_reader :xml, :validator

    def invalid?
      !valid?
    end
  end
end
