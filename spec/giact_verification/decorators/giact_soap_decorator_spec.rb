require 'spec_helper'

describe GiactVerification::GiactSoapDecorator do
  it 'decorates strings as strings' do
    key_value_pair_to_decorate = { key: :foo, value: 'bar' }

    decorated_pair = GiactVerification::GiactSoapDecorator.call(key_value_pair_to_decorate)

    expect(decorated_pair).to eq([:foo, 'bar'])
  end

  it 'decorates integers as strings' do
    key_value_pair_to_decorate = { key: :foo, value: 10 }

    decorated_pair = GiactVerification::GiactSoapDecorator.call(key_value_pair_to_decorate)

    expect(decorated_pair).to eq([:foo, '10'])
  end

  it 'decorates floats as strings' do
    key_value_pair_to_decorate = { key: :foo, value: 10.01 }

    decorated_pair = GiactVerification::GiactSoapDecorator.call(key_value_pair_to_decorate)

    expect(decorated_pair).to eq([:foo, '10.01'])
  end

  it 'decorates anything that responds to :strftime as a \'YYY-MM-DD\' string' do
    dateable = double('date', strftime: '1000-09-01')
    key_value_pair_to_decorate = { key: :foo, value: dateable }

    decorated_pair = GiactVerification::GiactSoapDecorator.call(key_value_pair_to_decorate)

    expect(decorated_pair).to eq([:foo, '1000-09-01'])
  end

  it 'decorates any of the designated \'KEYS_TO_UPCASE\' by upcasing them' do
    key = GiactVerification::GiactSoapDecorator::KEYS_TO_UPCASE.sample
    key_value_pair_to_decorate = { key: key, value: 'xx' }

    decorated_pair = GiactVerification::GiactSoapDecorator.call(key_value_pair_to_decorate)

    expect(decorated_pair).to eq([key, 'XX'])
  end
end
