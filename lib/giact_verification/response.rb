module GiactVerification
  class Response
    attr_reader :raw_request, :raw_response, :parsed_response, :success

    def initialize(args)
      @raw_request     = args[:raw_request]
      @raw_response    = args[:raw_response]
      @parsed_response = args[:parsed_response]
      @success         = args[:success]
    end

    def success?
      success
    end
  end
end
