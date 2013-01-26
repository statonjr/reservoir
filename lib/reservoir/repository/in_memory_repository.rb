module Reservoir
  class InMemoryRepository
    def initialize
      @entities = []
    end

    def add(entity)
      @entities << entity
      entity
    end

    def all
      @entities
    end
  end
end
