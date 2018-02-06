require 'spec_helper'

describe GiactVerification::Check do

  describe '#invalid?' do
    it 'is invalid if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: false))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1234567'}, validation_class: mock_validator)

      expect(customer.invalid?).to eq(false)
    end

    it 'is not invalid if the validator was successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: true))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1432870'}, validation_class: mock_validator)

      expect(customer.invalid?).to eq(true)
    end

    it 'exposes errors if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: true, messages: {name: ['is bad']}))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1298374'}, validation_class: mock_validator)

      expect(customer.errors).to include(:name)
    end
  end
end
