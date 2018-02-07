require 'dry-validation'

CustomerValidator = Dry::Validation.Schema do

  configure do
    config.messages_file = File.join(GiactVerification.config_directory, 'customer_validator_errors.yml')

    def serviced_state?(state)
      GiactVerification.servicing?(state.upcase)
    end

    def serviced_country?(country)
      GiactVerification.servicing_country?(country.upcase)
    end

    def postal_code?(value)
      [5, 7, 10].include?(value.to_s.length)
    end

    def phone_number_format?(value)
      value.to_s =~ /[1-9][0-9]{9}/
    end

    def phone_number_length?(value)
      value.to_s.length == 10
    end

    def last_four_ssn_length?(value)
      value.to_s.length == 4
    end

    def ssn_or_ein_length?(value)
      value.to_s.length == 9
    end

    def respond_to_strftime?(value)
      value.respond_to?(:strftime)
    end

    def drivers_license_length?(value)
      (1..28).include?(value.to_s.length)
    end

    def accepted_alternative_id?(id_type)
      GiactVerification.accepts_id_type?(id_type)
    end

    def alternative_id_number_length?(alternative_id_number)
      (1..50).include?(alternative_id_number.to_s.length)
    end
  end

  optional(:name_prefix) { none?   | size?(1..4)  }
  required(:first_name)  { filled? & size?(2..40) }
  optional(:middle_name) { none?   | size?(1..40) }
  required(:last_name)   { filled? & size?(2..40) }
  optional(:name_suffix) { none?   | size?(1..4)  }

  required(:address_line1)            { filled? & size?(2..40) }
  optional(:address_line2)            { none?   | size?(1..40) }
  required(:city)                     { filled? & size?(2..25) }
  required(:state)                    { filled? & size?(2) & serviced_state? }
  required(:zip_code)                 { filled? & number? & postal_code? }
  optional(:country)                  { filled? & serviced_country? }
  required(:phone_number)             { filled? & number? & phone_number_length? & phone_number_format? }
  required(:tax_id)                   { filled? & number? & (last_four_ssn_length? | ssn_or_ein_length?) }
  required(:date_of_birth)            { filled? & (date? | date_time? | respond_to_strftime?) }
  optional(:drivers_license_number)   { none? | drivers_license_length? }
  optional(:drivers_license_state)    { none? | (filled? & serviced_state?) }
  optional(:email_address)            { none? | size?(1..100) }
  optional(:current_ip_address)       { none? | size?(1..15) }
  optional(:mobile_consent_record_id) { none? | number? }
  optional(:alternative_id_type)      { none? | accepted_alternative_id? }
  optional(:alternative_id_issuer)    { none? | (str? & size?(1..50)) }
  optional(:alternative_id_number)    { none? | (number? & alternative_id_number_length?) }
  optional(:domain)                   { none? | (str? & size?(1..100)) }
end
