require 'time'
require_relative 'reservation'

module Hotel
  class HotelAdmin
    attr_reader  :rooms, :reservations, :reservation, :block_start_date, :block_end_date, :room_amt, :blocks, :block, :rooms_held, :block_name
    attr_accessor :status

    def initialize
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
      @blocks = []
      @holds_reservations = []
      @rooms_held = []
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

    def reserve_available_room(checkin_request, checkout_request)
      avail_room = view_available_rooms(checkin_request, checkout_request)[0]
      add_reservation(Hotel::Reservation.new({checkin_date: checkin_request, checkout_date: checkout_request, room_id: avail_room}))
    end

    def create_block(input)

      if input[:block_start_date] == nil || input[:block_end_date] == nil
        raise ArgumentError.new("Date must be a date.")
      end

      if input[:block_start_date] >= input[:block_end_date]
        raise ArgumentError.new("End date must be after start date.")
      end

      if input[:room_amt] > 5 || input[:room_amt] < 1
        raise ArgumentError.new("Rooms must be between 1 and 5.")
      end

      if input[:room_amt] > 5 || input[:room_amt] < 1
        raise ArgumentError.new("Rooms must be between 1 and 5.")
      end

      if input[:room_amt] > view_available_rooms(input[:block_start_date], input[:block_end_date]).count
        raise ArgumentError.new("There are not enough rooms available during that time.")
      end
      @block_start_date = input[:block_start_date]
      @block_end_date = input[:block_end_date]
      @room_amt = input[:room_amt]
      @block_name = input[:group_name]
      @blocks << input
      @block = input
      input[:room_amt].times do |i|
        avail_room = view_available_rooms(input[:block_start_date], input[:block_end_date])[0]
        new_res = add_reservation(Hotel::Reservation.new({checkin_date: input[:block_start_date], checkout_date:  input[:block_end_date], room_id: avail_room, status: "held", group_name: input[:group_name]}))
        @rooms_held  << avail_room
        @holds_reservations << new_res
      end
      return @block
    end

    def return_blocks_rooms(input)
      @rooms_held
    end

    def return_held_reservations
      @holds_reservations
    end

    def check_block_availability(group_name)
      arr_available_held_rooms = []
      @holds_reservations
      @holds_reservations.each do |res|
        if res.status == "held" && res.party_name == group_name
          arr_available_held_rooms << res
        end
      end
      return arr_available_held_rooms
    end

    def reserve_room_in_block(group_name)
      block_res = check_block_availability(group_name)[0]
      block_res.status = "booked"
    end
  end
end
