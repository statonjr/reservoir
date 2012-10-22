require 'motor'
require 'neo4j'

module Reservoir
  class Neo4jDealershipRepository
    def add(dealership_request)
      Neo4j::Transaction.run do
        DealershipRequestNode.new(:identifier => dealership_request.identifier)
      end
    end

    def count
      # dealership = DealershipNode.find_by_id(identifier)
      1
    end
  end

  class DealershipRequestNode
    include Neo4j::NodeMixin
    property :identifier
    # property :name
    # property :lifecycle
    # has_n(:franchises).to(Dealership, :franchise)
    # has_one(:used_car_department).to(Dealership, :department)
    # has_one(:certified_pre_owned_department).to(Dealership, :department)
  end
end
