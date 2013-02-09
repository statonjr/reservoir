require 'spec_helper'

describe Reservoir::InMemoryRepository do
  let(:repo) { described_class.new }

  after do
    repo.empty
  end

  describe '#save' do
    it 'accepts a hash' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership}
      expect{ repo.save(request) }.to_not raise_exception
    end
    it 'creates a key if none given' do
      request = {:kind => :dealership}
      result = repo.save(request)
      expect(result[:key]).to_not be_nil
    end
    it 'raises ArgumentError if no kind' do
      request = {:key => 'dealership-a1-b2-c3'}
      expect { repo.save(request) }.to raise_error(ArgumentError)
    end
    it 'returns a hash with key, kind, created if no value given' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership}
      result = repo.save(request)
      expect(result[:key]).to_not be_nil
      expect(result[:kind]).to_not be_nil
      expect(result[:created]).to_not be_nil
    end
    it 'returns a hash with key, kind, created, value if value given' do
      request = {:kind => :dealership, :name => 'Hendrick BMW'}
      result = repo.save(request)
      expect(result[:key]).to_not be_nil
      expect(result[:kind]).to_not be_nil
      expect(result[:created]).to_not be_nil
      expect(result[:name]).to_not be_nil
    end
    it 'does not overwrite keys' do
      request = {:kind => :dealership, :name => 'Hendrick BMW', :key => 'dealership-12-34-bc'}
      result1 = repo.save(request)
      request2 = {:kind => :dealership, :name => 'Hendrick BMW Northlake', :key => 'dealership-12-34-bc'}
      expect{ repo.save(request2) }.to_not raise_exception
    end
  end

  describe "#find_by_key" do
    it 'accepts a key' do
      expect{ repo.find_by_key('dealership-12-34-bc') }.to_not raise_exception
    end
    it 'raises ArgumentError if no key' do
      expect{ repo.find_by_key }.to raise_error(ArgumentError)
    end
    it 'returns a hash' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.find_by_key('dealership-a1-b2-c3')
      expect(result).to be_kind_of(Array)
    end
    it 'returns the right entity by key' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.find_by_key('dealership-a1-b2-c3').first
      expect(result[:key]).to eq('dealership-a1-b2-c3')
    end
  end

  describe "#find_by_kind" do
    it 'accepts a kind' do
      expect{ repo.find_by_kind(:dealership) }.to_not raise_exception
    end
    it 'raises ArgumentError if no kind' do
      expect{ repo.find_by_kind }.to raise_error(ArgumentError)
    end
    it 'returns a hash' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.find_by_kind(:dealership)
      expect(result).to be_kind_of(Array)
    end
    it 'returns the right kind of entity' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.find_by_kind(:dealership)
      expect(result.first[:kind]).to eq(:dealership)
    end
    it 'returns the right number of entities' do
      bmw = {:kind => :dealership, :name => "Hendrick BMW"}
      repo.save(bmw)
      northlake = {:kind => :dealership, :name => "Hendrick BMW Northlake"}
      repo.save(northlake)
      result = repo.find_by_kind(:dealership)
      expect(result.length).to eq(2)
    end
  end

  describe '#delete_by_key' do
    it 'accepts a key' do
      expect{ repo.delete_by_key('dealership-12-34-ab') }.to_not raise_exception
    end
    it 'raises ArgumentError if no key' do
      expect{ repo.delete_by_key }.to raise_error(ArgumentError)
    end
    it 'returns the right entity by key with :deleted => true' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.delete_by_key('dealership-a1-b2-c3')
      expect(result.first[:deleted]).to be_true
    end
  end

  describe '#delete_by_kind' do
    it 'accepts a kind' do
      expect{ repo.delete_by_kind(:dealership) }.to_not raise_exception
    end
    it 'raises ArgumentError if no kind' do
      expect{ repo.delete_by_kind }.to raise_error(ArgumentError)
    end
    it 'returns the right kind of entity with :deleted => true' do
      request = {:key => 'dealership-a1-b2-c3', :kind => :dealership, :name => "Hendrick BMW"}
      repo.save(request)
      result = repo.delete_by_kind(:dealership)
      expect(result.first[:deleted]).to be_true
    end
  end
end
