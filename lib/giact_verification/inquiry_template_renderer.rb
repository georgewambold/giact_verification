require 'erb'

module GiactVerification
  class InquiryTemplateRenderer

    def self.call(args)
      new(args).call
    end

    def initialize(args)
      @substitutions = args[:substitutions]
      @filepath      = GiactVerification.inquiry_template_directory
    end

    def call
      ERB.new(template_contents, nil, '>').result(binding)
    end

    private
    attr_reader :substitutions, :filepath, :rendered_template

    def template_contents
      File.read(filepath)
    end
  end
end
