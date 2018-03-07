
module Hotel
  class Room
    attr_reader :room, :cost
    COST = 200

    def initialize(room_num)
      @room = room_num
    end

    def price
      @cost = COST
    end

  end
end
