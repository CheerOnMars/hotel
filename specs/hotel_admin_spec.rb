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

end
