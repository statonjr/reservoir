module Reservoir
  class InMemoryRepository
    ROOT = {}

    def add(request)
      begin
        current_entities = ROOT.fetch("hendrick:#{request.context[:kind]}s")
        new_entities = current_entities.dup << request.context
        ROOT.store("hendrick:#{request.context[:kind]}s", new_entities)
      rescue KeyError
        entities = [request.context]
        ROOT.store("hendrick:#{request.context[:kind]}s", entities)
      end
      ROOT
    end

    def count
      ROOT.size
    end

    def all
      ROOT
    end

    # Searches the in-memory repository for the requested entity.
    #
    # @param request [Motor::Request] the request object
    # @return [Enumerable,nil] an Enumerable with the results or nil if not found
    def find(request)
      unless request.class == Motor::Request
        fail ArgumentError, "#find accepts Motor::Request objects"
      else
        ROOT.each do |k,v|
          ROOT[k].select { |val| val[:identifier] == request.context[:identifier] }
        end
      end
    end

    # Searches the in-memory repository for the requested entity by kind.
    #
    # @param (see #find)
    # @return (see #find)
    def find_by_kind(request)
      unless request.class == Motor::Request
        fail ArgumentError, "#find accepts Motor::Request objects"
      else
        namespace = ROOT.fetch("hendrick:#{request.context[:kind]}s")
        namespace.select { |v| v[:identifier] == request.context[:identifier] }
      end
    end

    def empty
      ROOT.clear
    end

  end
end
