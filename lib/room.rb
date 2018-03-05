
module Hotel
  class Room
    attr_reader :room, :cost
    COST = 200

    def initialize(input)
      @room = input
    end

    def price
      @cost = COST
    end

  end
end
