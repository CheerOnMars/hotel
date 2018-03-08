
module Hotel
  class Room
    attr_reader :room_num, :cost
    COST = 200

    def initialize(room_num)
      @room_num = room_num
    end

    def price
      @cost = COST
    end

  end
end
