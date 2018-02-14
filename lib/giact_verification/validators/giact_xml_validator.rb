module GiactVerification
  class GiactXmlValidator

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @xml = args[:xml]
    end

    def call
      begin
        GiactVerification::ExtractInquiryResult.call(xml: xml)
      rescue GiactVerification::MalformedXmlError
        false
      else
        true
      end
    end

    private
    attr_reader :xml
  end
end
