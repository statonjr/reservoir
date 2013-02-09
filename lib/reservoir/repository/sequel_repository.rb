require 'motor'
require 'sequel'

class String
  def pluralize
    self + "s"
  end
end

module Reservoir
  class SequelRepository
    def save(request)
      fail ArgumentError, "#save requires a :kind value" unless request[:kind]
      # TODO: Create an InsertBuilder class
      keyed_request = Reservoir::KeyCreator.new(request).create
      time_stamped_request = Reservoir::Timestamper.new(keyed_request).create
      sql_table = time_stamped_request.fetch(:kind).to_s.pluralize.to_sym
      query = time_stamped_request.dup
      query.delete(:kind)
      DB[sql_table].insert(query)
      time_stamped_request
    end

    def find_by_kind(kind, opts={})
      fail ArgumentError, "#find_by_kind requires a :kind value" if kind.nil?
      # TODO: Create a SelectBuilder class
      table = kind.to_s.pluralize.to_sym
      if opts[:filter]
        result_set = DB[table].filter(opts.fetch(:filter)).all
      else
        result_set = DB[table].all
      end
      result_set.map { |e| e.merge(:kind => kind) }
    end

    def find_by_key(key)
      fail ArgumentError, "#find_by_key requires a :key value" if key.nil?
      kind, identifier = decompose_key(key)
      find_by_kind(kind, {:filter => {:key => key, :deleted => false}})
    end

    def delete_by_key(key)
      fail ArgumentError, "#delete_by_key requires a :key value" if key.nil?
      kind, identifier = decompose_key(key)
      find_by_key(key).map { |e| e.merge(:deleted => true) }
    end

    def delete_by_kind(kind)
      fail ArgumentError, "#delete_by_kind requires a :kind value" if kind.nil?
      find_by_kind(kind).map { |e| e.merge(:deleted => true) }
    end

    def empty
      DB.tables.each { |table| DB[table].delete }
    end

    private
    def decompose_key(key)
      split_key = key.split("-")
      table = key.split("-").first.to_sym
      identifier = split_key.last(split_key.length - 1).join("-")
      [table, identifier]
    end
  end
end
