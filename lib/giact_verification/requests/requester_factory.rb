module GiactVerification
  class RequesterFactory
    def self.call
      new.call
    end

    def initialize
      @endpoint_set_to = GiactVerification.giact_endpoint
    end

    def call
      case endpoint_set_to
      when :production
        GiactVerification::ProductionRequester
      when :sandbox
        GiactVerification::SandboxRequester
      when :stubbed
        GiactVerification::StubbedRequester
      end
    end

    private
    attr_reader :endpoint_set_to
  end
end
