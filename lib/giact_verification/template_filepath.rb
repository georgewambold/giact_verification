module GiactVerification
  class TemplateFilepath
    class Error < Errno::ENOENT;end;

    def self.for(args)
      new(args).for
    end

    def initialize(args)
      @template_name  = args[:template_name]
      @global_filepath = "#{GiactVerification.template_directory}/#{template_name}.xml.erb"
    end

    def for
      if file_does_not_exist?
        raise Error, global_filepath
      end

      global_filepath
    end

    private
    attr_reader :template_name, :global_filepath

    def file_does_not_exist?
      !File.exist?(global_filepath)
    end
  end
end
