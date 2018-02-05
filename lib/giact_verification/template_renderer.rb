require 'erb'

module GiactVerification
  class TemplateRenderer
    attr_reader :substitutions, :filepath, :rendered_template

    def initialize(args)
      @substitutions = args[:substitutions]
      @filepath      = GiactVerification::TemplateFilepath.for(template_name: args[:template_name])
    end

    def render
      ERB.new(template_contents).result(binding)
    end

    private

    def template_contents
      File.read(filepath)
    end
  end
end
