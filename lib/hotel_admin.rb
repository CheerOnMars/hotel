require 'time'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class HotelAdmin
    attr_reader  :rooms, :reservations, :reservation

    def initialize
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations << reservation
      @reservation = reservation
      return @reservation
    end

    def calc_reservations(reservation)
      reservation.price_night * reservation.calc_duration
    end

    def access_reservations(day)
      days_reservations = []
      @reservations.each do |reservation|
        checkin_date_local = reservation.checkin_date.strftime("%Y-%m-%d")
        checkout_date_local = reservation.checkout_date.strftime("%Y-%m-%d")
        if (checkin_date_local...checkout_date_local).include?(day)
          days_reservations << reservation
        end
      end
      return days_reservations
    end

  end
end
