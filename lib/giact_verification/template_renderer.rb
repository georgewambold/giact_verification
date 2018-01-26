module GiactVerification
  class TemplateRenderer
    class TemplateError < Errno::ENOENT;end;

    def initialize(args)
      @template = args[:template]
      @substitutions = args[:substitutions]
      @filepath = File.join(GiactVerification.template_directory, (template + '.xml.erb'))
    end

    def render
      if template_does_not_exist?
        raise TemplateError, filepath
      else
        @rendered_template = ERB.new(File.read(filepath)).result(binding)
      end

      rendered_template
    end

    private
    attr_reader :template, :substitutions, :filepath, :rendered_template

    def template_does_not_exist?
      !File.exist?(filepath)
    end
  end
end
