require 'nori'

module GiactVerification
  class XmlToHash

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @xml    = args[:xml]
      @parser = args[:parser] || Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym})
    end

    def call
      parser.parse(xml)
    end

    private
    attr_reader :xml, :parser
  end
end
