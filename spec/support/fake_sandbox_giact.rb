require 'sinatra'

class FakeSandboxGiact < Sinatra::Base
  post '/verificationservices/v5/InquiriesWS-5-8.asmx' do
    content_type 'text/xml'
    status 200
    body File.read(File.join(GiactVerification.root, 'spec', 'fixtures', 'sandbox_customer_response.xml'))
  end
end

