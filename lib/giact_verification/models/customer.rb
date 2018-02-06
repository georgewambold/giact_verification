require 'ostruct'

module GiactVerification
  class Customer < OpenStruct

    def initialize(args)
      @attributes        = args[:attributes]
      @validation_class  = args[:validation_class] || CustomerValidator

      super(attributes)
    end

    def invalid?
      validator.failure?
    end

    def errors
      validator.messages
    end

    def decorate_for_xml
      GiactVerification::DecorateHash.call(hashable: self)
    end

    private
    attr_reader :validation_class, :attributes

    def validator
      @validator ||= validation_class.call(self.to_h)
    end
  end
end

