require 'time'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :room_id

    def initialize(input)

      if input[:checkin_date] == nil || input[:checkout_date] == nil
        raise ArgumentError.new("Date must be a date.")
      end

      input[:checkin_date] = Time.parse(input[:checkin_date])
      input[:checkout_date] = Time.parse(input[:checkout_date])

      if input[:checkin_date] >= input[:checkout_date]
        raise ArgumentError.new("End date must be after start date.")
      end

      @checkin_date = input[:checkin_date]
      @checkout_date = input[:checkout_date]
      @room_id = input[:room_id]
      @price_night = 200

    end

    def price_night
      @price_night
    end

    def calc_duration
      ((@checkout_date - @checkin_date) / 86400).to_i
    end

  end
end
