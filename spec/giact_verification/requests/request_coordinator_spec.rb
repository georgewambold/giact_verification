require 'spec_helper'

describe GiactVerification::RequestCoordinator do

  it 'takes injected classes and passes their return values on' do
    api_response    = double('api_response', code: '200', body: '<some>xml</xml>')
    parsed_response = double('parsed_response', success: true, body: {some: "xml"})
    requester       = double('requester', call: api_response)
    parser          = double('parser', call: parsed_response)

    response = GiactVerification::RequestCoordinator.new(
      body: "<request>xml</request>",
      requester: requester,
      parser: parser
    ).call

    expect(response.raw_request).to eq("<request>xml</request>")
    expect(response.raw_response).to eq('<some>xml</xml>')
    expect(response.success).to eq(true)
    expect(response.parsed_response).to eq({some: "xml"})
  end
end
