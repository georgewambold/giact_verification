require 'spec_helper'

describe GiactVerification::InquiryTemplateRenderer do
  describe '.render' do
    it 'renders a template with the correct substitutions' do
      allow(File).to receive(:read)
        .and_return("name: <%= substitutions[:customer][:name] %>")

      rendered_template = GiactVerification::InquiryTemplateRenderer.render(template_name: 'foo', substitutions: {customer: { name: 'bar' }})

      expect(rendered_template).to include('bar')
    end
  end
end
