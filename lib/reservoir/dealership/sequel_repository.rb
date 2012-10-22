require 'motor'
require 'sequel'

module Reservoir
  class SequelDealershipRepository
    def add(dealership_request)
      DealershipRequestRecord.create(:identifier => dealership_request.identifier)
    end

    def count
      DB[:dealerships].count
    end
  end

  class DealershipRequestRecord < Sequel::Model(:dealerships)
  end
end
