require 'net/http'

module GiactVerification
  class Request

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @endpoint = GiactVerification.giact_uri
      @body     = args[:body]
    end

    def call
      http = Net::HTTP.new(endpoint.host, endpoint.port)
      http.use_ssl = true

      response = http.post(endpoint.path, body, 'Content-Type' => 'text/xml')

      parsed_response = GiactVerification::ResponseParser.call(response: response)

      GiactVerification::Response.new(
        raw_request:     body,
        raw_response:    response.body,
        success:         parsed_response.success,
        parsed_response: parsed_response.body
      )
    end

    private
    attr_reader :endpoint, :body
  end
end
