module GiactVerification
  class Endpoint
    attr_reader :type, :uri

    def initialize
      raise RuntimeError, "Must define initialize in child class with @type and @uri"
    end

    def mount
    end

    def dismount
    end
  end
end

