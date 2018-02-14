module GiactVerification
  class ExtractInquiryResult

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @xml  = args[:xml]
      @hash = GiactVerification::XmlToHash.call(xml: xml)
    end

    def call
      @inquiry_result = hash.dig(:'soap:envelope', :'soap:body', :post_inquiry_response, :post_inquiry_result)

      if inquiry_result == nil
        raise MalformedXmlError, xml
      end

      inquiry_result
    end

    private
    attr_reader :xml, :hash, :inquiry_result
  end
end
