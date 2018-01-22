require 'spec_helper'

describe CustomerValidator do
  def minimum_customer_params
    {
      first_name: 'Sandi',
      last_name: 'Metz',

      address_line_1: '123 Test Dr.',
      city: 'Duck',
      state: 'NN',
      zip_code: 10023,

      phone_number: '1234567890',
      tax_id: '123456789',
      date_of_birth: Date.new(1990, 2, 15),
      drivers_license_number: 'L1234567',
      drivers_license_state: 'NN'
    }
  end

  before do
    allow(GiactVerification).to receive(:servicing?).with('NN')
      .and_return(true)
  end

  context 'name_prefix' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ name_prefix: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ name_prefix: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ name_prefix: 'M' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 4 characters' do
      params = minimum_customer_params.merge({ name_prefix: 'atty' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be 5 characters' do
      params = minimum_customer_params.merge({ name_prefix: 'count' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'first_name' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ first_name: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ first_name: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be 2 characters' do
      params = minimum_customer_params.merge({ first_name: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 40 characters' do
      params = minimum_customer_params.merge({ first_name: ('-' * 40) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 40 characters long' do
      params = minimum_customer_params.merge({ first_name: ('-' * 41) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'middle_name' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ middle_name: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ middle_name: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ middle_name: 'Q' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 40 characters' do
      params = minimum_customer_params.merge({ middle_name: ('-' * 40) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 40 characters' do
      params = minimum_customer_params.merge({ middle_name: ('-' * 41) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

  end

  context 'last_name' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ last_name: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ last_name: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be less than 2 characters long' do
      params = minimum_customer_params.merge({ last_name: 'z' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 2 characters long' do
      params = minimum_customer_params.merge({ last_name: 'yi' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end


    it 'can be 40 characters' do
      params = minimum_customer_params.merge({ last_name: ('-' * 40) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 40 characters' do
      params = minimum_customer_params.merge({ last_name: ('-' * 41) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'name_suffix' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ name_suffix: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ name_suffix: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ name_suffix: 'M' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 4 characters' do
      params = minimum_customer_params.merge({ name_suffix: 'pres' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be 5 characters' do
      params = minimum_customer_params.merge({ name_suffix: 'count' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'address_line_1' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ address_line_1: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ address_line_1: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be less than 2 characters' do
      params = minimum_customer_params.merge({ address_line_1: 'z' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 2 characters' do
      params = minimum_customer_params.merge({ address_line_1: '5A' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end


    it 'can be 40 characters' do
      params = minimum_customer_params.merge({ address_line_1: ('-' * 40) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 40 characters' do
      params = minimum_customer_params.merge({ address_line_1: ('-' * 41) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'address_line_2' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ address_line_2: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ address_line_2: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ address_line_2: 'z' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 40 characters' do
      params = minimum_customer_params.merge({ address_line_2: ('-' * 40) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 40 characters' do
      params = minimum_customer_params.merge({ address_line_2: ('-' * 41) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'city' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ city: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ city: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be 1 characters' do
      params = minimum_customer_params.merge({ city: 'z' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 2 characters' do
      params = minimum_customer_params.merge({ city: '5A' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end


    it 'can be 25 characters' do
      params = minimum_customer_params.merge({ city: ('-' * 25) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 25 characters' do
      params = minimum_customer_params.merge({ city: ('-' * 26) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'state' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ state: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ state: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a non-serviced state (US state or CA province)' do
      allow(GiactVerification).to receive(:servicing?)
        .and_return(false)

      params = minimum_customer_params.merge({ state: 'QQ' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a serviced state (US state or CA province)' do
      allow(GiactVerification).to receive(:servicing?)
        .and_return(true)

      params = minimum_customer_params.merge({ state: 'BB' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'zip_code' do
    it 'can\'t be nil ' do
      params = minimum_customer_params.merge({ zip_code: nil })

      validator = CustomerValidator.call(params)


      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string ' do
      params = minimum_customer_params.merge({ zip_code: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be less than 5 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 1234 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 5 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 12345 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be 6 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 123456 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 7 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 1234567 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be 8 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 12345678 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be 9 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 123456789 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 10 digits long ' do
      params = minimum_customer_params.merge({ zip_code: 1234567890 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 10 digits' do
      params = minimum_customer_params.merge({ zip_code: 123456789012345 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a string ' do
      params = minimum_customer_params.merge({ zip_code: '12345' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be an integer' do
      params = minimum_customer_params.merge({ zip_code: 12345 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t include non-numeric characters ' do
      params = minimum_customer_params.merge({ zip_code: '1234P' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'country' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ country: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ country: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a non-serviced country (US or CA)' do
      allow(GiactVerification).to receive(:servicing_country?).with('OO')
        .and_return(false)
      params = minimum_customer_params.merge({ country: 'OO' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a serviced state (US state or CA province)' do
      allow(GiactVerification).to receive(:servicing_country?).with('UU')
        .and_return(true)

      params = minimum_customer_params.merge({ country: 'UU' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'phone_number' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ phone_number: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ phone_number: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be less than 10 characters' do
      params = minimum_customer_params.merge({ phone_number: '123456789' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be more than 10 characters' do
      params = minimum_customer_params.merge({ phone_number: '12345678901' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 10 characters' do
      params = minimum_customer_params.merge({ phone_number: '1234567890' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t start with a 0' do
      params = minimum_customer_params.merge({ phone_number: '0987654321' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be an integer' do
      params = minimum_customer_params.merge({ phone_number: 1234567890 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'tax_id' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ tax_id: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ tax_id: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be less than 4 characters' do
      params = minimum_customer_params.merge({ tax_id: '123' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 4 characters' do
      params = minimum_customer_params.merge({ tax_id: '1234' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be 5 characters' do
      params = minimum_customer_params.merge({ tax_id: '12345' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be 8 characters' do
      params = minimum_customer_params.merge({ tax_id: '12345678' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 9 characters' do
      params = minimum_customer_params.merge({ tax_id: '123456789' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 9 characters' do
      params = minimum_customer_params.merge({ tax_id: '1234567890' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be an integer' do
      params = minimum_customer_params.merge({ tax_id: 123456789 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be a string' do
      params = minimum_customer_params.merge({ tax_id: '123456789' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t contain non-numeric characters' do
      params = minimum_customer_params.merge({ tax_id: 'AAA456789' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'date_of_birth' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ date_of_birth: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ date_of_birth: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be an integer' do
      params = minimum_customer_params.merge({ date_of_birth: 2015521 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a date in string format' do
      params = minimum_customer_params.merge({ date_of_birth: '2015-5-21' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a Date object' do
      params = minimum_customer_params.merge({ date_of_birth: Date.parse('jan 20 2012') })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be a DateTime object' do
      params = minimum_customer_params.merge({ date_of_birth: DateTime.parse('sept 15 2012') })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be any date object that responds to strftime' do
      date_duck = double('date_duck', strftime: true)
      params = minimum_customer_params.merge({ date_of_birth: date_duck})

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'drivers_license_number' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ drivers_license_number: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ drivers_license_number: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ drivers_license_number: '1' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 28 characters' do
      params = minimum_customer_params.merge({ drivers_license_number: ('o' * 28) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 28 characters' do
      params = minimum_customer_params.merge({ drivers_license_number: ('o' * 29) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a integer' do
      params = minimum_customer_params.merge({ drivers_license_number: 12345 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be a integer' do
      params = minimum_customer_params.merge({ drivers_license_number: '12345' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'drivers_license_state' do
    it 'can\'t be nil' do
      params = minimum_customer_params.merge({ drivers_license_state: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ drivers_license_state: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a non-serviced state (US state or CA province)' do
      allow(GiactVerification).to receive(:servicing?).with('ZZ')
        .and_return(false)
      params = minimum_customer_params.merge({ drivers_license_state: 'ZZ' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be a serviced state (US state or CA province)' do
      allow(GiactVerification).to receive(:servicing?).with('BB')
        .and_return(true)

      params = minimum_customer_params.merge({ drivers_license_state: 'BB' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'email_address' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ email_address: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ email_address: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ email_address: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 100 characters' do
      params = minimum_customer_params.merge({ email_address: ('-' * 100) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 100 characters' do
      params = minimum_customer_params.merge({ email_address: ('-' * 101) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'ip_address' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ ip_address: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ ip_address: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ ip_address: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 15 characters' do
      params = minimum_customer_params.merge({ ip_address: ('-' * 15) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 15 characters' do
      params = minimum_customer_params.merge({ ip_address: ('-' * 16) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'mobile_consent_record_id' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ mobile_consent_record_id: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ mobile_consent_record_id: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a non-blank string' do
      params = minimum_customer_params.merge({ mobile_consent_record_id: '12345' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be an integer' do
      params = minimum_customer_params.merge({ mobile_consent_record_id: 10 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'alternative_id_type' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ alternative_id_type: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      allow(GiactVerification).to receive(:accepts_id_type?)
      params = minimum_customer_params.merge({ alternative_id_type: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be a non-accepted alternative ID type' do
      allow(GiactVerification).to receive(:accepts_id_type?).and_return(false)
      params = minimum_customer_params.merge({ alternative_id_type: 'invalid_type' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be an accepted alternative ID type' do
      allow(GiactVerification).to receive(:accepts_id_type?).and_return(true)
      params = minimum_customer_params.merge({ alternative_id_type: 'valid_type' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end
  end

  context 'alternative_id_issuer' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ alternative_id_issuer: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ alternative_id_issuer: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ alternative_id_issuer: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 50 characters' do
      params = minimum_customer_params.merge({ alternative_id_issuer: ('-' * 50) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 50 characters' do
      params = minimum_customer_params.merge({ alternative_id_issuer: ('-' * 51) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be an integer' do
      params = minimum_customer_params.merge({ alternative_id_issuer: 123 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'alternative_id_number' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ alternative_id_number: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ alternative_id_number: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ alternative_id_number: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 50 characters' do
      params = minimum_customer_params.merge({ alternative_id_number: ('-' * 50) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 50 characters' do
      params = minimum_customer_params.merge({ alternative_id_number: ('-' * 51) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be an integer' do
      params = minimum_customer_params.merge({ alternative_id_number: 123 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end

  context 'domain' do
    it 'can be nil' do
      params = minimum_customer_params.merge({ domain: nil })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be a blank string' do
      params = minimum_customer_params.merge({ domain: '' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can be 1 character' do
      params = minimum_customer_params.merge({ domain: 'a' })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can be 100 characters' do
      params = minimum_customer_params.merge({ domain: ('-' * 100) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(true)
    end

    it 'can\'t be more than 100 characters' do
      params = minimum_customer_params.merge({ domain: ('-' * 101) })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end

    it 'can\'t be an integer' do
      params = minimum_customer_params.merge({ domain: 123 })

      validator = CustomerValidator.call(params)

      expect(validator.success?).to be(false)
    end
  end
end

