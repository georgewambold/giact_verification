require 'spec_helper'

describe CheckValidator do
  def minimum_check_params
    {
      routing_number: '123456789',
      account_number: '00000'
    }
  end

  context 'routing_number' do
    it 'can\'t be nil' do
      params = minimum_check_params.merge(routing_number: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_check_params.merge(routing_number: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be less than 9 characters' do
      params = minimum_check_params.merge(routing_number: 'foo')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be 9 characters' do
      params = minimum_check_params.merge(routing_number: '123456789')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can\'t be more than 9 characters' do
      params = minimum_check_params.merge(routing_number: '1234567890')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be an integer' do
      params = minimum_check_params.merge(routing_number: 123456789)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be a string' do
      params = minimum_check_params.merge(routing_number: '123456789')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end
  end

  context 'account_number' do
    it 'can\'t be nil' do
      params = minimum_check_params.merge(account_number: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_check_params.merge(account_number: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be less than 4 characters' do
      params = minimum_check_params.merge(account_number: '123')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be 4 characters' do
      params = minimum_check_params.merge(account_number: '1234')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can be 17 characters' do
      params = minimum_check_params.merge(account_number: ('0' * 17))

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can\'t be more than 17 characters' do
      params = minimum_check_params.merge(account_number: ('0' * 18))

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be an integer' do
      params = minimum_check_params.merge(account_number: 123456789)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be a string' do
      params = minimum_check_params.merge(account_number: '123456789')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end
  end

  context 'check_number' do
    it 'can be nil' do
      params = minimum_check_params.merge(check_number: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_check_params.merge(check_number: '')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be a any string' do
      params = minimum_check_params.merge(check_number: 'asdf')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be an integer' do
      params = minimum_check_params.merge(check_number: 1234567)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end
  end

  context 'check_amount' do
    it 'can be nil' do
      params = minimum_check_params.merge(check_amount: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_check_params.merge(check_amount: '')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be a any string' do
      params = minimum_check_params.merge(check_amount: 'asdf')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be an integer' do
      params = minimum_check_params.merge(check_amount: 1234567)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can be an float' do
      params = minimum_check_params.merge(check_amount: 100.00)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end
  end

  context 'account_type' do
    it 'can be nil' do
      params = minimum_check_params.merge(account_type: nil)

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_check_params.merge(account_type: '')

      validator = CheckValidator.call(params)

      expect(validator.success?).to eq(false)
    end

    it 'can\'t be a non-valid account type(Checking, Savings, or Other)' do
      allow(GiactVerification).to receive(:valid_account_type?)
        .and_return(false)
      params = minimum_check_params.merge({ account_type: 'invalid_account' })

      validator = CheckValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a valid account type(Checking, Savings, or Other)' do
      allow(GiactVerification).to receive(:valid_account_type?)
        .and_return(true)

      params = minimum_check_params.merge({ account_type: 'valid_account' })

      validator = CheckValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end
end
