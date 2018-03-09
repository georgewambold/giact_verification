
require 'spec_helper'

describe GiactVerification::SandboxRequester do
  it 'responds to call' do
    expect(GiactVerification::SandboxRequester).to respond_to(:call)
  end
end
