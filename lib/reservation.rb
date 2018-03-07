require 'time'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date

    def initialize(input)

      if input[:start_date] == nil || input[:end_date] == nil
        raise ArgumentError.new("Date must be a date.")
      end

      input[:start_date] = Time.parse(input[:start_date])
      input[:end_date] = Time.parse(input[:end_date])

      if input[:start_date] >= input[:end_date]
        raise ArgumentError.new("End date must be after start date.")
      end

      #add room_id ArgumentError if necessary

      @start_date = input[:start_date]
      @end_date = input[:end_date]
      @room_id = input[:room_id]

    end

    def length
      ((@end_date - @start_date) / 86400).to_i
    end

    # def puts_self
    #   puts Hotel::Reservation.new
    # end

    def start_date
      @start_date
    end

    def end_date
      @end_date
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
