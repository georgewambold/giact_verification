require 'spec_helper'

describe GiactVerification::Customer do

  describe '#invalid?' do
    it 'is invalid if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: true))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.invalid?).to eq(true)
    end

    it 'is not invalid if the validator was successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: false))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.invalid?).to eq(false)
    end

    it 'exposes errors if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', failure?: true, messages: {name: ['is bad']}))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.errors).to include(:name)
    end
  end
end
