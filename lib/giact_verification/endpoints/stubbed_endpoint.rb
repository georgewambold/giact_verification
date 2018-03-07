require 'webmock'

module GiactVerification
  class StubbedEndpoint
    attr_reader :type, :uri

    def initialize
      @type = :stubbed
      @uri  = URI.parse('https://fake.giact.com/verificationservices/v5/InquiriesWS-5-8.asmx').freeze
    end

    def mount
      @stubbed_request = WebMock.stub_request(:any, /fake.giact.com/).to_rack(FakeGiact)
    end

    def dismount
      WebMock.remove_request_stub(@stubbed_request)
    end
  end
end
