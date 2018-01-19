require 'spec_helper'
require 'ostruct'

describe GiactVerification::DecorateHash do
  describe '.call' do
    context 'using an arbitrary decorator' do
      it 'returns the decorator\'s value' do
        arbitrary_decorator = double('Decorator', call: 'decorated_value')
        hashable = OpenStruct.new({ foo: 'Metz' })

        decorated = GiactVerification::DecorateHash.call(hashable: hashable, decorator: arbitrary_decorator)

        expect(decorated).to eq({ foo: 'decorated_value' })
      end
    end
  end
end

