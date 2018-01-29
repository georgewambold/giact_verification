module GiactVerification
  class Response
    attr_reader :raw_request, :raw_response, :parsed_response, :code

    def self.from_xml(args)
      parsed_response = GiactVerification::XmlToHash.call(xml: args[:raw_response].body)
      response_body = parsed_response[:'soap:envelope'][:'soap:body'][:post_inquiry_response][:post_inquiry_result]

      new(
        raw_request:     args[:raw_request],
        raw_response:    args[:raw_response].body,
        code:            args[:raw_response].code,
        parsed_response: response_body
      )
    end

    def initialize(args)
      @raw_request      = args[:raw_request]
      @raw_response     = args[:raw_response]
      @parsed_response  = args[:parsed_response]
      @code             = args[:code]
    end
  end
end
