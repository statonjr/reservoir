require 'spec_helper'

describe InMemoryRepository do
  subject(:repo) { described_class.new }
  let(:dealership) { double("Dealership", :id => SecureRandom.uuid) }

  describe '#initialize' do
    it 'should create a place to hold the things in the repository' do
      expect(repo.objects).to_not be_nil
    end
    it 'should take a configuration object'
  end

  describe '#save' do
    it 'should save the object' do
      repo.save(dealership)
      expect(repo.objects.length).to_not be_nil
    end
    it 'should return true if save successful' do
      result = repo.save(dealership)
      expect(result).to eq(true)
    end
  end

  describe '#find_by_id' do
    it 'should find the right thing' do
      repo.save(dealership)
      result = repo.find_by_id(dealership.id)
      expect(result).to eq(dealership)
    end
  end
end
