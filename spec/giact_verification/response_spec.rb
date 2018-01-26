require 'spec_helper'

describe GiactVerification::Response do
  describe '#body' do
    it 'exists' do
      expect(GiactVerification::Response.new).to respond_to(:body)
    end
  end
end
