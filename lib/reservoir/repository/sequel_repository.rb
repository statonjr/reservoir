require 'motor'
require 'sequel'

module Reservoir
  class SequelRepository
    def add(entity)
      RequestRecord.create(entity)
    end

    def all
      DB[:dealerships]
    end

    def count
      DB[:dealerships].count
    end
  end

  class RequestRecord < Sequel::Model(:dealerships)
  end
end
