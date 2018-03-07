require 'time'
require_relative 'reservation'
require_relative 'room'

module Hotel
  class HotelAdmin
    attr_reader  :rooms, :reservations, :unit, :reservation

    def initialize
      @rooms = []
      @reservations = []
    end

    def load_rooms
      room_arr = []
      [*1..20].each do |n|
        room = Room.new(n)
        #      @unit = unit
        room_arr << room
        @rooms = room_arr
      end
      return @rooms #room_arr
    end

    def add_reservation(reservation)
      # new_reservation = (reservation)
      # reservations_arr << new_reservation
      @reservations << reservation
      #  @reservation = new_reservation
    end

    def calc_reservations(room, reservation)
      room.price * reservation.length
    end

    def access_reservations(day)
      days_reservations = []
      @reservations.each do |reservation|
        if day.between?(reservation.start_date.strftime("%Y-%m-%d"),reservation.end_date.strftime("%Y-%m-%d"))

          days_reservations << reservation
        end
      end
      return days_reservations
    end


    # def load_reservations
    #   reservations_arr = []
    #   reservation = Hotel::Reservation.new
    #   input[:start_date]
    #   input[:end_date]
    #   reservations_arr << reservation
    #   return reservations_arr
    # end

    # def load_reservations
    #
    # end

  end
end
