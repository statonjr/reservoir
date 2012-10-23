require 'spec_helper'
require 'neo4j_helper'

describe Reservoir::Neo4jDealershipRepository do
  subject(:repo) { described_class.new }

  after(:all) do
    FileUtils.rm_rf Neo4j::Config[:storage_path]
  end

  describe "#add" do
    it 'adds dealership requests' do
      request = stub(:dealership => stub(:identifier => SecureRandom.uuid))
      request.should_receive(:identifier)
      subject.add(request)
      expect(subject.count).to eq(1)
    end
  end
end
