module GiactVerification
  class Response
    attr_reader :raw_request, :raw_response, :parsed_response, :code

    def initialize(args)
      @raw_request      = args[:raw_request]
      @raw_response     = args[:raw_response]
      @parsed_response  = args[:parsed_response]
      @code             = args[:code]
    end
  end
end
