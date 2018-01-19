module GiactVerification
  class GiactSoapDecorator
    def self.call(value)
      new(value).call
    end

    def initialize(value)
      @value = value
    end

    def call
      if value.methods.include?(:strftime)
        value.strftime('%Y-%m-%d')
      else
        value.to_s
      end
    end

    private
    attr_reader :value
  end
end
