require_relative 'spec_helper'

describe "Reservation class" do
  describe "Initializer" do
    it "is an instance of Reservation" do
      reservation = Hotel::Reservation.new({start_date: "2015-07-20", end_date: "2015-07-25"})
      reservation.must_be_kind_of Hotel::Reservation
    end

    it "throws an argument error for a bad start date" do
      proc{ Hotel::Reservation.new({start_date: nil, end_date: "2015-07-20" }) }.must_raise ArgumentError
    end

    it "throws an argument error for a bad end date" do
      proc{ Hotel::Reservation.new({start_date: "2015-07-20", end_date: nil }) }.must_raise ArgumentError
    end

    it "throws an argument error when end date isn't after start date" do
      proc{ Hotel::Reservation.new({start_date: "2015-07-20", end_date: "2015-07-20" }) }.must_raise ArgumentError
      proc{ Hotel::Reservation.new({start_date: "2015-07-21", end_date: "2015-07-20" }) }.must_raise ArgumentError
    end
  end

  describe "length method" do
    it "calculates the number of nights for the hotel stay" do
      @reservation = Hotel::Reservation.new({start_date: "2015-07-20", end_date: "2015-07-25"})
        @reservation.length.must_equal 5
      end
    end

  end
