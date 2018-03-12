require_relative 'spec_helper'

describe "HotelAdmin class" do
  describe "Initializer" do
    it "is an instance of TripDispatcher" do
      hotel_admin = Hotel::HotelAdmin.new
      hotel_admin.must_be_kind_of Hotel::HotelAdmin
    end

    it "establishes the base data structures when instantiated" do
      hotel_admin = Hotel::HotelAdmin.new
      [:rooms, :reservations].each do |i|
        hotel_admin.must_respond_to i
      end
      hotel_admin.rooms.must_be_kind_of Array
      hotel_admin.reservations.must_be_kind_of Array
    end

    it "lists of all of the rooms in the hotel" do
      hotel_admin = Hotel::HotelAdmin.new
      hotel_admin.rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end
  end

  describe "dates reservations method" do
    it "can reserve a room for a given date range" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation_a = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1})
      new_res = hotel_admin.add_reservation(reservation_a)
      hotel_admin.reservations.must_include new_res
    end

    it "returns a list of reservations for a specific date" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation_a = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1})
      reservation_b = Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2})
      hotel_admin.add_reservation(reservation_a)
      hotel_admin.add_reservation(reservation_b)
      hotel_admin.access_reservations("2015-07-21").must_equal [reservation_a]
      hotel_admin.access_reservations("2015-07-22").must_equal [reservation_a, reservation_b]
      hotel_admin.access_reservations("2015-07-19").must_equal []
      hotel_admin.access_reservations("2015-07-25").must_equal []
    end
  end

  describe "calculates reservation cost" do
    it "calculates the cost of a given reservation" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1})
      hotel_admin.calc_reservations(reservation).must_equal 1000
      hotel_admin.calc_reservations(reservation).must_be_instance_of Integer
    end
  end

  describe "can view a list of rooms that are not reserved for a given date range" do
    it "can test 1" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation_a = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1})
      reservation_b = Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2})
      hotel_admin.add_reservation(reservation_a)
      hotel_admin.add_reservation(reservation_b)
      hotel_admin.view_available_rooms("2015-07-20", "2015-07-23").must_equal [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
  end

  describe "can reserve an available room for a given date range" do
    it "" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation_a = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1})
      reservation_b = Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2})
      hotel_admin.add_reservation(reservation_a)
      hotel_admin.add_reservation(reservation_b)
      new_res = hotel_admin.reserve_available_room("2015-07-20", "2015-07-23")
      new_res.must_be_kind_of Hotel::Reservation
      new_res.checkin_date.must_equal "2015-07-20"
      new_res.checkout_date.must_equal "2015-07-23"
      new_res.room_id.must_equal 3

    end
  end

end
