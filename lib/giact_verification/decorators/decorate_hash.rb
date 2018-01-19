module GiactVerification
  class DecorateHash

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @input = args[:hashable].to_h
      @decorator = args.fetch(:decorator, GiactVerification::GiactSoapDecorator)
    end

    def call
      input.map do |key, value|
        [key, decorator.call(value)]
      end.to_h
    end

    private
    attr_reader :input, :decorator
  end
end
