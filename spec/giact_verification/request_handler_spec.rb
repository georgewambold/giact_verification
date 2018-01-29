require 'spec_helper'

describe GiactVerification::RequestHandler do

  it 'raises an error if given a request type that is not supported' do
    allow(GiactVerification).to receive(:supports_request_type?)
      .and_return(false)

    expect {
      GiactVerification::RequestHandler.call(template_name: 'foo')
    }.to raise_error(GiactVerification::RequestHandler::RequestTypeError)

    reset_config!
  end
end
