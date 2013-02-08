require 'spec_helper'
require 'neo4j_helper'

describe Reservoir::Neo4jDealershipRepository do
  let(:dealership) { double("Dealership") }
  let(:request) { double("DealershipRequest", dealership: dealership) }
  let(:repo) { described_class.new }

  after(:all) do
    FileUtils.rm_rf Neo4j::Config[:storage_path]
  end

  describe "#add" do
    it 'adds dealership requests' do
      repo.add(request)
      expect(repo.count).to eq(1)
    end
  end

  describe "#find_by_code" do
    it 'finds the right dealership' do
      request.should_receive(:identifier)
      repo.add(request)
      repo.should_receive(:three_letter_code)
      result = repo.find_by_code(request)
      expect(result).to eq(dealership)
    end
  end
end
