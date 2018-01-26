require 'spec_helper'

describe GiactVerification::TemplateRenderer do
  describe '.call' do
    it' should throw an error if called with a template that doesn\'t exist' do
      expect {
        GiactVerification::TemplateRenderer.new(template: 'foo', substitutions: { name: 'fail plz' }).render
      }.to raise_error(GiactVerification::TemplateRenderer::TemplateError)
    end

    it' should not throw an error if called with a template that does exist' do
      expect {
        body = GiactVerification::TemplateRenderer.new(template: 'inquiry', substitutions: { name: 'fail plz' }).render
      }.to_not raise_error
    end
  end
end
