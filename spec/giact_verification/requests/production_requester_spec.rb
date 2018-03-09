require 'spec_helper'

describe GiactVerification::ProductionRequester do
  it 'responds to call' do
    expect(GiactVerification::ProductionRequester).to respond_to(:call)
  end
end
