require 'ostruct'

module GiactVerification
  class Check < OpenStruct

    def initialize(args)
      @attributes        = args[:attributes]
      @validation_class  = args[:validation_class] || CheckValidator
      @validator         = validation_class.call(attributes)

      super(attributes)
    end

    def valid?
      validator.success?
    end

    def errors
      validator.messages
    end

    private
    attr_reader :validation_class, :validator, :attributes
  end
end

