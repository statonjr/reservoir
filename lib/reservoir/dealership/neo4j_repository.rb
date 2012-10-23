require 'motor'
require 'neo4j'

module Reservoir
  class Neo4jDealershipRepository
    def add(dealership_request)
      Neo4j::Transaction.run do
        DealershipNode.new(:identifier => dealership_request.identifier, :type => "dealership")
      end
    end

    def count
      DealershipNode.find(:type => "dealership").count
    end
  end

  class DealershipNode
    include Neo4j::NodeMixin
    property :identifier
    property :type, :index => :exact
    # property :name
    # property :lifecycle
    # has_n(:franchises).to(Dealership, :franchise)
    # has_one(:used_car_department).to(Dealership, :department)
    # has_one(:certified_pre_owned_department).to(Dealership, :department)
  end
end
