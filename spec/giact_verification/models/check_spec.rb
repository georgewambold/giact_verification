require 'spec_helper'

describe GiactVerification::Check do

  describe '#valid?' do
    it 'is valid if the validator was successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: true))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1234567'}, validation_class: mock_validator)

      expect(customer.valid?).to eq(true)
    end

    it 'is not valid if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: false))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1432870'}, validation_class: mock_validator)

      expect(customer.valid?).to eq(false)
    end

    it 'exposes errors if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: false, messages: {name: ['is bad']}))

      customer = GiactVerification::Check.new(attributes: {routing_number: '1298374'}, validation_class: mock_validator)

      expect(customer.errors).to include(:name)
    end
  end
end
