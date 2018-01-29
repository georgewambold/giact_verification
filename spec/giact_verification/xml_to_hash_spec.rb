require 'spec_helper'

describe GiactVerification::XmlToHash do
  it 'calls parse on the parser' do
    parser = double('parser', parse: { tag: 'some contents' })
    result = GiactVerification::XmlToHash.call(xml: "<tag>some contents</tag>")

    expect(result[:tag]).to eq('some contents')
  end
end
