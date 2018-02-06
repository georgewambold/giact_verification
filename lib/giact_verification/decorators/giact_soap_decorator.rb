module GiactVerification
  class GiactSoapDecorator

    KEYS_TO_UPCASE = [:state, :drivers_license_state, :country]

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @key   = args[:key]
      @value = args[:value]
    end

    def call
      [key, modified_value]
    end

    private
    attr_reader :key, :value

    def modified_value
      if value.methods.include?(:strftime)
        value.strftime('%Y-%m-%d')
      elsif KEYS_TO_UPCASE.include?(key)
        value.upcase
      else
        value.to_s
      end
    end
  end
end
