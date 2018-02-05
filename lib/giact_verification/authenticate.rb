module GiactVerification
  class Authenticate

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      GiactVerification.ready_for_request?

      @customer = GiactVerification::Customer.new(attributes: args.fetch(:customer, {}))
      @check    = GiactVerification::Check.new(attributes: args.fetch(:check, {}))
    end


    def call
      if customer.valid? && check.valid?
        GiactVerification::RequestHandler.call(request_type: 'inquiry', substitutions: substitutions)
      else
        raise GiactVerification::ArgumentError, param_errors
      end
    end

    private
    attr_reader :customer, :check

    def substitutions
      {
        check: check.decorate_for_xml,
        customer: customer.decorate_for_xml,
        g_authenticate_enabled: true
      }
    end

    def param_errors
      (customer.errors.merge(check.errors)).map do |k,v|
        "#{k}: #{v}\n"
      end.join('')
    end
  end
end
