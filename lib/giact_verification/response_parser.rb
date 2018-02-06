module GiactVerification
  class ResponseParser

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @response = args[:response]
    end

    def call
      if giact_authentication_error?(response)
        raise HTTPError, response.body
      else
        GiactVerification::ExtractInquiryResult.call(xml: response.body)
      end
    end

    private
    attr_reader :response

    def giact_authentication_error?(response)
      response.body =~ /Invalid API Credentials/
    end
  end
end
