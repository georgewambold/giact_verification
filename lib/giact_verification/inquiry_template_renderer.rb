require 'erb'

module GiactVerification
  class InquiryTemplateRenderer

    def self.render(args)
      new(args).render
    end

    def initialize(args)
      @substitutions = args[:substitutions]
      @filepath      = GiactVerification.inquiry_template_directory
    end

    def render
      ERB.new(template_contents, nil, '>').result(binding)
    end

    private
    attr_reader :substitutions, :filepath, :rendered_template

    def template_contents
      File.read(filepath)
    end
  end
end
