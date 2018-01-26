module GiactVerification
  class Request

    def initialize(args)
      @body         = args[:body]
      @headers      = args[:headers]
    end

  end
end
