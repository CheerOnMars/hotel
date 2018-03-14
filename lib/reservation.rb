require 'time'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :room_id, :status , :price_night

    def initialize(input)

      if input[:checkin_date] == nil || input[:checkout_date] == nil
        raise ArgumentError.new("Date must be a date.")
      end

      if input[:checkin_date] >= input[:checkout_date]
        raise ArgumentError.new("End date must be after start date.")
      end

      @checkin_date = input[:checkin_date]
      @checkout_date = input[:checkout_date]
      @room_id = input[:room_id]
      @price_night = 200
      @status = input[:status]
    end

    def calc_duration
      ((checkin_date...checkout_date).map{ |date| date}).count
    end

  end
end
