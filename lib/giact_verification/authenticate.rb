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
      if customer.invalid? || check.invalid?
        raise GiactVerification::ArgumentError, param_errors
      end

      GiactVerification::Request.call(body: request_body)
    end

    private
    attr_reader :customer, :check

    def request_body
      @request_body ||= GiactVerification::InquiryTemplateRenderer.call(substitutions: substitutions)
    end

    def substitutions
      {
        g_authenticate_enabled: true,
        check: check.decorate_for_xml,
        customer: customer.decorate_for_xml,
      }
    end

    def param_errors
      (customer.errors.merge(check.errors)).map do |k,v|
        "#{k}: #{v}\n"
      end.join('')
    end
  end
end
