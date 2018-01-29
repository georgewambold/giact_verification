require 'spec_helper'

describe GiactVerification::TemplateRenderer do
  describe '.render' do
    it 'renders a template with the correct substitutions' do
      allow(GiactVerification::TemplateFilepath).to receive(:for)
      allow(File).to receive(:read)
        .and_return("name: <%= substitutions[:customer][:name] %>")

      template_renderer =
        GiactVerification::TemplateRenderer.new(template_name: 'foo', substitutions: {customer: { name: 'bar' }})

      expect(template_renderer.render).to include('bar')
    end

    it '' do
      allow(GiactVerification::TemplateFilepath).to receive(:for)
      allow(File).to receive(:read)
        .and_return("name: <%= substitutions[:customer][:name] %>")

      template_renderer =
        GiactVerification::TemplateRenderer.new(template_name: 'foo', substitutions: {customer: { name: 'bar' }})

      expect(template_renderer.render).to include('bar')
    end
  end
end
