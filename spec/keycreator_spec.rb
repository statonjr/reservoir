require 'spec_helper'

describe Reservoir::KeyCreator do
  let(:request) { { :kind => :dealership } }
  let(:keyed_request) { { :kind => :dealership, :key => 'dealership-1234-abc' } }

  describe '#create' do
    it 'returns :key if :key exists' do
      k = Reservoir::KeyCreator.new(keyed_request)
      expect(k.create).to eq(keyed_request)
    end
    it 'creates :key with the :kind prepended' do
      k = Reservoir::KeyCreator.new(request)
      result = k.create
      expect(result[:key]).to match(/^#{request[:kind]}-/)
    end
  end
end
