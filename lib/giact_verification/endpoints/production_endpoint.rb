module GiactVerification
  class ProductionEndpoint < Endpoint

    def initialize
      @type = :production
      @uri  = URI.parse('https://api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze
    end
  end
end
