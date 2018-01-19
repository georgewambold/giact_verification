require 'spec_helper'

describe GiactVerification::Customer do

  describe '#valid?' do
    it 'is valid if the validator was successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: true))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.valid?).to eq(true)
    end

    it 'is not valid if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: false))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.valid?).to eq(false)
    end

    it 'exposes errors if the validator was not successful' do
      mock_validator = double('validator')
      allow(mock_validator).to receive(:call)
        .and_return(instance_double('validator', success?: false, messages: {name: ['is bad']}))

      customer = GiactVerification::Customer.new(attributes: {name: 'Joe'}, validation_class: mock_validator)

      expect(customer.errors).to include(:name)
    end
  end
end
