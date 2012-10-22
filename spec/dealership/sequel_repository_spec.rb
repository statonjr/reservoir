require 'spec_helper'
require 'sequel_helper'

describe Reservoir::SequelDealershipRepository do
  subject(:repo) { described_class.new }

  after(:all) do
    DB.drop_table(:dealerships)
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
