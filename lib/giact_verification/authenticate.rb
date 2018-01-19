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
      if GiactVerification.configuration.invalid?
        raise GiactVerification::ConfigurationError
      elsif params_have_errors?
        raise GiactVerification::ArgumentError
      else
        GiactVerification::Response.new
      end
    end

    private
    attr_reader :customer, :check

    def params_have_errors?
      customer.nil? || check.nil?
    end
  end
end
