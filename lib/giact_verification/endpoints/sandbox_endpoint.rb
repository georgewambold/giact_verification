module GiactVerification
  class SandboxEndpoint < Endpoint

    def initialize
      @type = :sandbox
      @uri  = URI.parse('https://sandbox.api.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze
    end
  end
end

