class Neo4jRepository
  attr_reader :objects, :class_name

  def initialize
    @objects = []
    @class_name = ""
  end

  def save(object)
    @objects << object
  end

  def find_by_id(id)
    # Delegate to neography?
  end

  def persist(object)
    # Delegate to neography?
  end
end
