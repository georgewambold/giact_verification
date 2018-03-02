require 'ostruct'

module GiactVerification
  class ResponseParser

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @response  = args[:response]
    end

    def call
      if successful_request?
        OpenStruct.new({ body: giact_xml.inquiry_result, success: true })
      else
        OpenStruct.new({ body: {}, success: false })
      end
    end

    private
    attr_reader :response

    def successful_request?
      response.code == "200" && giact_xml.valid?
    end

    def giact_xml
      @giact_xml ||= GiactVerification::GiactXml.new(xml: response.body)
    end
  end
end


