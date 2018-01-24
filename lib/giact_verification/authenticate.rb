module GiactVerification
  class Authenticate

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @customer = args[:customer]
      @check    = args[:check]
    end

    def call
      GiactVerification.ready_for_request?

      if params_valid?
        #
      else
        raise GiactVerification::ArgumentError, param_errors
      end

      GiactVerification::Response.new
    end

    private
    attr_reader :customer, :check

    def params_valid?
      customer_validator.success? && check_validator.success?
    end

    def param_errors
      (customer_validator.messages.merge check_validator.messages).map do |k,v|
        "#{k}: #{v}\n"
      end.join('')
    end

    def customer_validator
      @customer_validator ||= CustomerValidator.call(customer)
    end

    def check_validator
      @check_validator ||= CheckValidator.call(check)
    end
  end
end
