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

      GiactVerification::Response.new(
        raw_request:  body,
        raw_response: response,
        parsed_response: GiactVerification::ResponseParser.call(response: response)
      )
    end

    private
    attr_reader :endpoint, :body
  end
end
