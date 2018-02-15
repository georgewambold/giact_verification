module GiactVerification
  class Response
    attr_reader :raw_request, :raw_response, :parsed_response, :status

    def initialize(args)
      @raw_request     = args[:raw_request]
      @raw_response    = args[:raw_response]
      @parsed_response = args[:parsed_response]
      @status          = args[:status]
    end
  end
end
