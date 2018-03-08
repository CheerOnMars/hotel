require 'time'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date

    def initialize(input)

      if input[:checkin_date] == nil || input[:checkout_date] == nil
        raise ArgumentError.new("Date must be a date.")
      end

      input[:checkin_date] = Time.parse(input[:checkin_date])
      input[:checkout_date] = Time.parse(input[:checkout_date])

      if input[:checkin_date] >= input[:checkout_date]
        raise ArgumentError.new("End date must be after start date.")
      end

      #add room_id ArgumentError if necessary

      @checkin_date = input[:checkin_date]
      @checkout_date = input[:checkout_date]
      @room_id = input[:room_id]

    end

    def length
      ((@checkout_date - @checkin_date) / 86400).to_i
    end

    # def puts_self
    #   puts Hotel::Reservation.new
    # end

    def checkin_date
      @checkin_date
    end

    def checkout_date
      @checkout_date
    end

    #.strftime("%m/%d/%Y")

    # def self.all
    #   reservations_arr = []
    #   @reservation
    #   reservations_arr << reservation
    #   return reservations_arr
    # end

  end
end
