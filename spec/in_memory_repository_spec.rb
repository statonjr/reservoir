require 'spec_helper'

describe Reservoir::InMemoryRepository do
  let(:repo) { described_class.new }

  after do
    repo.empty
  end

  describe '#add' do
    it 'adds the entity in the request' do
      request = double("Motor::Request", :context => {:identifier => 'a1b2c3', :kind => :dealership})
      response = repo.add(request)
      expect(response).to be_kind_of(Hash)
    end
  end

  describe "#count" do
    it 'returns to proper count of entities of a specific kind' do
      request = double("Motor::Request", :context => {:identifier => 'a1b2c3', :kind => :dealership})
      repo.add(request)
      expect(repo.count).to eq(1)
    end
  end

  describe "#all" do
    it 'returns all entities' do
      request = double("Motor::Request", :context => {:identifier => 'a1b2c3', :kind => :dealership})
      repo.add(request)
      request2 = double("Motor::Request", :context => {:identifier => 'd4e5c6', :kind => :vehicle})
      repo.add(request2)
      expect(repo.all.count).to eq(2)
    end
  end

  describe "#find" do
    it 'accepts a Motor::Request' do
      request = Motor::Request.build({:identifier => 'a1b2c3', :kind => :dealership})
      repo.add(request)
      expect{ repo.find(request) }.to_not raise_exception
    end
    it 'raises ArgumentError if argument is not a Motor::Request' do
      request = double("Motor::Dealership")
      expect { repo.find(request) }.to raise_error(ArgumentError)
    end
    it 'returns an Enumerable' do
      request = Motor::Request.build({:identifier => 'a1b2c3', :kind => :dealership})
      request2 = Motor::Request.build({:identifier => 'a1b2c4', :kind => :dealership})
      repo.add(request)
      repo.add(request2)
      entity = repo.find(request)
      expect(entity).to be_kind_of(Enumerable)
    end
    it 'returns the right number of entities' do
      request = Motor::Request.build({:identifier => 'a1b2c3', :kind => :dealership})
      request2 = Motor::Request.build({:identifier => 'a1b2c3', :kind => :vehicle})
      repo.add(request)
      repo.add(request2)
      entity = repo.find(request)
      expect(entity.length).to eq(2)
    end
  end

  describe "#find_by_kind" do
    it 'accepts a Motor::Request' do
      request = Motor::Request.build({:identifier => 'a1b2c3', :kind => :dealership})
      repo.add(request)
      expect { repo.find_by_kind(request) }.to_not raise_exception
    end
    it 'raises ArgumentError if argument is not a Motor::Request' do
      request = double("Motor::Dealership")
      expect { repo.find_by_kind(request) }.to raise_error(ArgumentError)
    end
    it 'returns the requested entity' do
      request = Motor::Request.build({:identifier => 'a1b2c3', :kind => :dealership})
      request2 = Motor::Request.build({:identifier => 'a1b2c3', :kind => :vehicle})
      repo.add(request)
      repo.add(request2)
      entity = repo.find_by_kind(request)
      expect(entity).to eq([{:identifier => 'a1b2c3',:kind => :dealership}])
    end
  end
end
