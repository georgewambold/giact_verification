require 'net/http'

module GiactVerification
  class Request

    def self.post(args)
      new(args).post
    end

    def initialize(args)
      @endpoint = GiactVerification.giact_uri
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
