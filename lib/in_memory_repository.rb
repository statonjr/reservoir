class InMemoryRepository

  attr_reader :objects

  def initialize
    @objects = []
  end

  def find_by_id(id)
    result = @objects.select { |object| object.id == id }
    result.first
  end

  def save(object)
    if @objects << object
      true
    else
      false
    end
  end

end
