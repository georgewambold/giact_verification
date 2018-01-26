require 'sinatra'

class FakeGiact < Sinatra::Base

  post '/verificationservices/v5/InquiriesWS-5-8.asmx' do
    content_type :json
    status 200
    body "fuck off, mate"
  end
end
