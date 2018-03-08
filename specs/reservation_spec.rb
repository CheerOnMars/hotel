require_relative 'spec_helper'

describe "Reservation class" do
  describe "Initializer" do
    it "is an instance of Reservation" do
      reservation = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25"})
      reservation.must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error for a bad start date" do
      proc{ Hotel::Reservation.new({checkin_date: nil, checkout_date: "2015-07-20" }) }.must_raise ArgumentError
    end

    it "throws an argument error for a bad end date" do
      proc{ Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: nil }) }.must_raise ArgumentError
    end

    it "throws an argument error when end date isn't after start date" do
      proc{ Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-20" }) }.must_raise ArgumentError
      proc{ Hotel::Reservation.new({checkin_date: "2015-07-21", checkout_date: "2015-07-20" }) }.must_raise ArgumentError
    end
  end

  describe "calc_duration method" do
    it "calculates the number of nights for the hotel stay" do
      @reservation = Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25"})
      @reservation.calc_duration.must_equal 5
      @reservation.calc_duration.must_be_kind_of Integer
    end
  end

end
