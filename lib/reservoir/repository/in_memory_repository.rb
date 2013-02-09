module Reservoir
  class InMemoryRepository
    ROOT = {}

    def save(request)
      fail ArgumentError, "#save requires a #kind value" unless request[:kind]
      keyed_request = Reservoir::KeyCreator.new(request).create
      time_stamped_request = Reservoir::Timestamper.new(keyed_request).create
      begin
        current_entities = ROOT.fetch("hendrick:#{time_stamped_request.fetch(:kind)}s")
        new_entities = current_entities.dup << time_stamped_request
        ROOT.store("hendrick:#{time_stamped_request.fetch(:kind)}s", new_entities)
      rescue KeyError
        entities = []
        entities << time_stamped_request
        ROOT.store("hendrick:#{time_stamped_request.fetch(:kind)}s", entities)
      end
      time_stamped_request
    end

    def find_by_key(key)
      fail ArgumentError, "#find_by_key requires a :key value" if key.nil?
      ROOT.each do |k,v|
        return ROOT[k].select { |val| val[:key] == key }
      end
    end

    def find_by_kind(kind)
      fail ArgumentError, "#find_by_kind requires a :kind value" if kind.nil?
      namespace = ROOT.fetch("hendrick:#{kind}s", {})
      namespace.select { |v| v[:kind] == kind }
    end

    def delete_by_key(key)
      fail ArgumentError, "#delete_by_key requires a :key value" if key.nil?
      ROOT.each do |k,v|
        found_keys = ROOT[k].select { |val| val[:key] == key }
        deleted_keys = []
        found_keys.each do |k|
          deleted_keys << k.merge(:deleted => true)
        end
        return deleted_keys
      end
    end

    def delete_by_kind(kind)
      fail ArgumentError, "#delete_by_kind requires a :kind value" if kind.nil?
      entities = find_by_kind(kind)
      deleted_keys = []
      entities.each do |e|
        deleted_keys << e.merge(:deleted => true)
      end
      return deleted_keys
    end

    def empty
      ROOT.clear
    end

  end
end
