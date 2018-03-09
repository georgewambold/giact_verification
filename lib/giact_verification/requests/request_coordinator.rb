module GiactVerification
  class RequestCoordinator

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @body      = args[:body]
      @requester = args[:requester] || GiactVerification::RequesterFactory.call
      @parser    = args[:parser]    || GiactVerification::ResponseParser
    end

    def call
      response = requester.call(body: body)

      parsed_response = parser.call(response: response)

      GiactVerification::Response.new(
        raw_request:     body,
        raw_response:    response.body,
        success:         parsed_response.success,
        parsed_response: parsed_response.body
      )
    end

    private
    attr_reader :body, :parser, :requester
  end
end
