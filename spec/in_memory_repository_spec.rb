require 'spec_helper'

describe Reservoir::InMemoryRepository do
  let(:repo) { described_class.new }

  describe "#add" do
    it 'adds entities' do
      request = double("dealership")
      request.should_receive(:identifier).with("1234")
      repo.add(request)
      expect(repo.count).to eq(1)
    end
  end

  describe "#all" do
    it 'returns all dealerships' do
      request = double("dealership")
      repo.add(request)
      repo.all
      expect(repo.count).to eq(1)
    end
  end
end
