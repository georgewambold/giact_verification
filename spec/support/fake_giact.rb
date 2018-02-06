require 'sinatra'

class FakeGiact < Sinatra::Base

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
      body File.read(File.join(GiactVerification.root, 'spec', 'fixtures', 'bad_customer_response.xml'))
    when 'Error'
      content_type 'text/xml'
      status 200
      body File.read(File.join(GiactVerification.root, 'spec', 'fixtures', 'error_response.xml'))
    when 'AuthError'
      content_type 'text/xml'
      status 200
      body 'Error Message: Invalid API Credentials'
    when 'Blacklist'
      content_type 'text/html'
      status 401
      body File.read(File.join(GiactVerification.root, 'spec', 'fixtures', 'blacklisted_ip_address.html'))
    else
      content_type 'text/xml'
      status 200
      body File.read(File.join(GiactVerification.root, 'spec', 'fixtures', 'good_customer_response.xml'))
    end
  end
end

