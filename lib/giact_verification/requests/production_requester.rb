require 'uri'
require 'net/http'

module GiactVerification
  class ProductionRequester

    PRODUCTION_URI = URI.parse('https://api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @endpointable = PRODUCTION_URI
      @body         = args[:body]
    end

    def call
      http = Net::HTTP.new(endpointable.host, endpointable.port)
      http.use_ssl = true

      response = http.post(endpointable.path, body, 'Content-Type' => 'text/xml')
    end

    private
    attr_reader :endpointable, :body
  end
end
