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
      #note: this is tightly coupled, I think.
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
        # checkin_date_local = reservation.checkin_date.strftime("%Y-%m-%d")
        # checkout_date_local = reservation.checkout_date.strftime("%Y-%m-%d")
        if (reservation.checkin_date...reservation.checkout_date).include?(day)
          days_reservations << reservation
        end
      end
      return days_reservations
    end

    def view_available_rooms(checkin_request, checkout_request)
      arr_available_rooms = @rooms.map{ |room| room }
      date_range_requested = (checkin_request...checkout_request).map{ |date| date}
      @reservations.each do |res|
        date_range_requested.each do |day_requested|
          if (res.checkin_date...res.checkout_date).include?(day_requested)
            arr_available_rooms.delete(res.room_id)
          end
        end
      end
      return arr_available_rooms
    end

    # def reserve_available_room(checkin_request, checkout_request)
    #
    # end

  end
end
