require 'dry-validation'

CheckValidator = Dry::Validation.Schema do

  configure do
    def valid_account_type?(account_type)
      GiactVerification.valid_account_type?(account_type)
    end
  end

  required(:routing_number) { filled? & str? & size?(9) }
  required(:account_number) { filled? & str? & size?(4..17) }

  optional(:check_number)   { none? | (filled? & int?) }
  optional(:check_amount)   { none? | (filled? & float?) }
  optional(:account_type)   { none? | (filled? & str? & valid_account_type? ) }
end
