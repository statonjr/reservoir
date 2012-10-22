require 'spec_helper'
require 'neo4j_helper'

describe Reservoir::Neo4jDealershipRepository do
  subject(:repo) { described_class.new }

  describe "#add" do
    it 'adds dealership requests' do
      request = stub(:dealership => stub(:identifier => SecureRandom.uuid))
      request.should_receive(:identifier)
      subject.add(request)
      expect(subject.count).to eq(1)
    end
  end
end
