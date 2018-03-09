require 'ostruct'

module GiactVerification
  class StubbedRequester

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @body = args[:body]
    end

    def call
      hashed_request_body = XmlToHash.call(xml: body)

      response_body = response_for(hashed_request_body)

      response = OpenStruct.new({code: '200', body: response_body})
    end

    private
    attr_reader :body

    def response_for(hashed_body)
      last_name = hashed_body.dig(:'soap:envelope', :'soap:body', :post_inquiry, :inquiry, :customer, :last_name)

      case last_name
      when 'GiactDeclined'
        File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'requests', 'support', 'declined_response.xml'))
      when 'GiactError'
        File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'requests', 'support', 'error_response.xml'))
      else
        File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'requests', 'support', 'pass_response.xml'))
      end
    end
  end
end
