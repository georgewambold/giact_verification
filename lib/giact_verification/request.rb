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

      raw_response = http.post(endpoint.path, body, 'Content-Type' => 'text/xml')

      parsed_response = GiactVerification::ResponseParser.call(response: raw_response)

      GiactVerification::Response.new(
        raw_request: body,
        raw_response: raw_response,
        status: parsed_response.status,
        parsed_response: parsed_response.body
      )
    end

    private
    attr_reader :endpoint, :body
  end
end
