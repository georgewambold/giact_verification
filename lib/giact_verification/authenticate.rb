module GiactVerification
  class Authenticate
    TEMPLATE_NAME = 'inquiry'.freeze

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

      @response = GiactVerification::Request.post(body: request_body)

      GiactVerification::Response.new(
        raw_request:  request_body,
        raw_response: response,
        parsed_response: GiactVerification::ResponseParser.call(response: response)
      )
    end

    private
    attr_reader :customer, :check, :response

    def request_body
      @request_body ||= GiactVerification::TemplateRenderer.new(template_name: TEMPLATE_NAME, substitutions: substitutions).render
    end

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
