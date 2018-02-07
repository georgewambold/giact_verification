require 'dry-validation'

CheckValidator = Dry::Validation.Schema do

  configure do
    config.messages_file = File.join(GiactVerification.config_directory, 'check_validator_errors.yml')

    def valid_account_type?(account_type)
      GiactVerification.valid_account_type?(account_type)
    end

    def routing_number_length?(routing_number)
      routing_number.to_s.size == 9
    end

    def account_number_length?(account_number)
      (4..17).include?(account_number.to_s.size)
    end
  end

  required(:routing_number) { filled? & number? & routing_number_length? }
  required(:account_number) { filled? & number? & account_number_length? }

  optional(:check_number)   { none? | (filled? & number?) }
  optional(:check_amount)   { none? | (filled? & number?) }
  optional(:account_type)   { none? | (filled? & str? & valid_account_type? ) }
end
