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

    def find_by_code(dealership_request)
      puts DealershipNode.all.map { |d| d.props }
      DealershipNode.all.select { |d| d.three_letter_code == dealership_request.dealership.three_letter_code }.first
    end
  end

  class DealershipNode
    include Neo4j::NodeMixin
    rule :all
    property :identifier
    property :type, :index => :exact
    property :three_letter_code, :index => :exact
    # property :name
    # property :lifecycle
    # has_n(:franchises).to(Dealership, :franchise)
    # has_one(:used_car_department).to(Dealership, :department)
    # has_one(:certified_pre_owned_department).to(Dealership, :department)
  end
end
