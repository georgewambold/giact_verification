require 'net/http'

module GiactVerification
  class Request
    class ApiError < Net::HTTPServerException;end

    GIACT_URI = 'https://api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx'.freeze

    def self.post(args)
      new(args).post
    end

    def initialize(args)
      @endpoint = URI.parse(GIACT_URI)
      @body     = args[:body]
    end

    def post
      http = Net::HTTP.new(endpoint.host, endpoint.port)

      http.use_ssl = true

      response = http.post(endpoint.path, body, 'Content-Type' => 'text/xml')
    end

    private
    attr_reader :endpoint, :body
  end
end
