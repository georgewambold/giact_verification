module GiactVerification
  class EndpointFactory

    def self.for(args)
      type = args[:type]

      case type
      when :production
        GiactVerification::ProductionEndpoint.new
      when :sandbox
        GiactVerification::SandboxEndpoint.new
      when :stubbed
        GiactVerification::StubbedEndpoint.new
      else
        raise GiactVerification::ConfigurationError, "giact_endpoint #{type} is not supported. Supported types are :production, :sandbox and :stubbed."
      end
    end
  end
end
