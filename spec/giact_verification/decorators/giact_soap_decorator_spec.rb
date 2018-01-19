require 'spec_helper'

describe GiactVerification::GiactSoapDecorator do
  it 'decorates strings as strings' do
    value_to_decorate = 'foo'

    decorated_value = GiactVerification::GiactSoapDecorator.call(value_to_decorate)

    expect(decorated_value).to eq('foo')
  end

  it 'decorates integers as strings' do
    value_to_decorate = 10

    decorated_value = GiactVerification::GiactSoapDecorator.call(value_to_decorate)

    expect(decorated_value).to eq('10')
  end

  it 'decorates floats as strings' do
    value_to_decorate = 10.01

    decorated_value = GiactVerification::GiactSoapDecorator.call(value_to_decorate)

    expect(decorated_value).to eq('10.01')
  end

  it 'decorates anything that responds to :strftime as a \'YYY-MM-DD\' string' do
    dateable = double('date', strftime: '1000-09-01')

    decorated_value = GiactVerification::GiactSoapDecorator.call(dateable)

    expect(decorated_value).to eq('1000-09-01')
  end
end
