module Reservoir
  class Timestamper
    def initialize(hsh)
      @component = hsh
    end

    def create
      if @component[:created]
        @component
      else
        @component.merge(:created => Time.now.utc.to_i)
      end
    end
  end
end
