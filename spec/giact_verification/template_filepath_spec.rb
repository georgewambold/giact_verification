require 'spec_helper'

describe GiactVerification::TemplateFilepath do
  it 'returns an error if the file does not exist' do
    allow(File).to receive(:exist?)
      .and_return(false)

    expect {
      GiactVerification::TemplateFilepath.for(template_name: 'foo')
    }.to raise_error(GiactVerification::TemplateFilepath::Error)
  end

  it 'returns the global filepath if the file does exist' do
    allow(File).to receive(:exist?)
      .and_return(true)

    template_name = GiactVerification::TemplateFilepath.for(template_name: 'foo')

    expect(template_name).to be_a(String)
  end
end
