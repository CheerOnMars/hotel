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

      @start_date = input[:start_date]
      @end_date = input[:end_date]

    end

    def length
      (@end_date - @start_date) / 86400
    end

  end
end
