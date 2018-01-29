module GiactVerification
  class RequestHandler
    class RequestTypeError < StandardError;end;

    attr_reader :request_type

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @substitutions = args[:substitutions]
      @request_type  = args[:request_type]
    end

    def call
      unless GiactVerification.supports_request_type?(request_type)
        raise RequestTypeError, request_type
      end

      @raw_request  = render_request_body
      @raw_response = post_request

      GiactVerification::Response.from_xml(
        raw_request:  raw_request,
        raw_response: raw_response
      )
    end

    private
    attr_reader :substitutions, :raw_request, :raw_response

    def render_request_body
      GiactVerification::TemplateRenderer.new(template_name: request_type, substitutions: substitutions).render
    end

    def post_request
      GiactVerification::Request.post(body: raw_request)
    end
  end
end
