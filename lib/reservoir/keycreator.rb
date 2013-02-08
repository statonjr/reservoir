module Reservoir
  class KeyCreator
    def initialize(hsh)
      @component = hsh
    end

    def create
      if @component[:key]
        @component
      else
        @component.merge(:key => "#{@component.fetch(:kind)}-" + SecureRandom.uuid)
      end
    end
  end
end
