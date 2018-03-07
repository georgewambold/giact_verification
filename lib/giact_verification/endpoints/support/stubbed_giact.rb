require 'sinatra'

module GiactVerification
  class StubbedGiact < Sinatra::Base

    post '/verificationservices/v5/InquiriesWS-5-8.asmx' do
      request_body = Nori.new.parse(request.body.read)

      response_factory(request_body)
    end

    private

    def response_factory(body)
      customer =
        body['soap:Envelope']['soap:Body']['PostInquiry']['Inquiry']['Customer']

      case customer['FirstName']
      when 'Declined'
        content_type 'text/xml'
        status 200
        body File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'endpoints', 'support', 'bad_customer_response.xml'))
      when 'Error'
        content_type 'text/xml'
        status 200
        body File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'endpoints', 'support', 'error_response.xml'))
      when 'Pass'
        content_type 'text/xml'
        status 200
        body File.read(File.join(GiactVerification.root, 'lib', 'giact_verification', 'endpoints', 'support', 'good_customer_response.xml'))
      end
    end
  end
end
