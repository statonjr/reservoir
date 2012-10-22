require 'spec_helper'

describe Neo4jRepository do
  subject(:repo) { described_class.new }
  let(:dealership) { double("Dealership", :identifier => SecureRandom.uuid) }

  describe '#initialize' do
    it 'should figure out the class' do
      expect(repo.class_name).to eq("Dealership")
    end
    it 'should create an objects array' do
      expect(repo.objects).to_not be_nil
    end
  end

  describe '#save' do
    it 'should save the thing in-memory' do
      repo.save(dealership)
      expect(repo.objects.count).to eq(1)
    end
  end

  describe '#find_by_id' do
    it 'should find the right node'
  end

  describe '#persist' do
    it 'should save the object to the graph'
  end

end
