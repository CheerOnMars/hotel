require_relative 'spec_helper'

describe "HotelAdmin class" do
  describe "Initializer" do
    before do
      @hotel_admin = Hotel::HotelAdmin.new
    end

    it "is an instance of HotelAdmin" do
      @hotel_admin.must_be_kind_of Hotel::HotelAdmin
    end

    it "establishes the base data structures when instantiated" do
      [:rooms, :reservations].each do |i|
        @hotel_admin.must_respond_to i
      end
      @hotel_admin.rooms.must_be_kind_of Array
      @hotel_admin.reservations.must_be_kind_of Array
    end

    it "lists of all of the rooms in the hotel" do
      @hotel_admin.rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @hotel_admin.rooms.first.must_equal 1
      @hotel_admin.rooms.last.must_equal 20
    end
  end

  describe "dates reservations method" do
    before do
      @hotel_admin = Hotel::HotelAdmin.new
    end

    it "can reserve a room for a given date range" do
      new_res = @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      @hotel_admin.reservations.must_include new_res
    end

    it "returns a list of reservations for a specific date" do
      reservation_a = @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      reservation_b = @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2}))
      @hotel_admin.access_reservations("2015-07-21").must_equal [reservation_a]
      @hotel_admin.access_reservations("2015-07-22").must_equal [reservation_a, reservation_b]
      @hotel_admin.access_reservations("2015-07-19").must_equal []
      @hotel_admin.access_reservations("2015-07-25").must_equal []
    end
  end

  describe "calculates reservation cost" do
    it "calculates the cost of a given reservation" do
      hotel_admin = Hotel::HotelAdmin.new
      reservation = hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      hotel_admin.calc_reservations(reservation).must_equal 1000
      hotel_admin.calc_reservations(reservation).must_be_instance_of Integer
    end
  end

  describe "can view a list of rooms that are not reserved for a given date range" do
    it "can test 1" do
      hotel_admin = Hotel::HotelAdmin.new
      hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2}))
      hotel_admin.view_available_rooms("2015-07-20", "2015-07-23").must_equal [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    end
  end

  describe "can reserve an available room for a given date range" do
    it "" do
      hotel_admin = Hotel::HotelAdmin.new
      hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-22", checkout_date: "2015-07-24", room_id: 2}))
      new_res = hotel_admin.reserve_available_room("2015-07-20", "2015-07-23")
      new_res.must_be_kind_of Hotel::Reservation
      new_res.checkin_date.must_equal "2015-07-20"
      new_res.checkout_date.must_equal "2015-07-23"
      new_res.room_id.must_equal 3
    end
  end

  describe "creates blocks" do
    before do
      @hotel_admin = Hotel::HotelAdmin.new
    end

    #@block = Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_amt: 5})

    it "returns an error if block attempt has more than 5 rooms" do
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_amt: 6})}.must_raise ArgumentError
    end

    it "returns an error if block attempt has more than 5 rooms" do
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_amt: 6})}.must_raise ArgumentError
    end

    it "returns an error if block attempt has less than 1 room" do
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_amt: 0})}.must_raise ArgumentError
    end

    it "throws an argument error for a bad end date" do
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: nil }) }.must_raise ArgumentError
    end

    it "throws an argument error for a bad start date" do
      proc{ @hotel_admin.create_block({block_start_date: nil, block_end_date: "2015-07-20", room_amt: 3 }) }.must_raise ArgumentError
    end

    it "throws an argument error when end date isn't after start date" do
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: "2015-07-20", room_amt: 3 }) }.must_raise ArgumentError
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-21", block_end_date: "2015-07-20", room_amt: 3 }) }.must_raise ArgumentError
    end

    it "throws an argument error when there aren't enough rooms available" do
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 2}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 3}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 4}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 5}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 6}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 7}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 8}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 9}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 10}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 11}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 12}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 13}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 14}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 15}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 16}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 17}))
      proc{ @hotel_admin.create_block({block_start_date: "2015-07-23", block_end_date: "2015-07-29", room_amt: 5}) }.must_raise ArgumentError
    end

    it "can create a block of rooms" do
      block_new = @hotel_admin.create_block({block_start_date: "2015-07-26", block_end_date: "2015-07-29", room_amt: 4})
      @hotel_admin.create_block({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_amt: 3})
      block_new.must_be_instance_of Hash
      block_new[:room_amt].must_be_instance_of Integer
      block_new[:block_start_date].must_equal "2015-07-26"
      @hotel_admin.blocks.must_be_instance_of Array
      @hotel_admin.blocks.count.must_equal 2
    end

    it "excludes rooms in the block for reservations by general public" do
      @hotel_admin.create_block({block_start_date: "2015-07-26", block_end_date: "2015-07-29", room_amt: 5})
      new_res = @hotel_admin.reserve_available_room("2015-07-26", "2015-07-27")
      new_res.room_id.must_equal 6
    end

    it "can check whether a given block has any rooms available" do
      @hotel_admin.create_block({block_start_date: "2015-09-20", block_end_date: "2015-09-25", room_amt: 4, group_name: "Prince"})
      @hotel_admin.check_block_availability("Prince").must_be_instance_of Array
      @hotel_admin.check_block_availability("Prince").length.must_equal 4
    end

    it "can reserve a room from within a block of rooms" do
      new_hold = @hotel_admin.create_block({block_start_date: "2015-07-26", block_end_date: "2015-07-29", room_amt: 5, group_name: "Bowie"})
      block_res = @hotel_admin.reserve_room_in_block("Bowie")
      puts "XXXXXXXXXxxxxxxxxxx block_res xxxxxxxxxxXXXXXXXXX"
      block_res.class.must_be_kind_of Hotel::Reservation
      block_res.status.must_equal "booked"
    end

  end

  describe "return_blocks_rooms method" do
    before do
      @hotel_admin = Hotel::HotelAdmin.new
    end

    it "only includes rooms that are available for the given date range" do
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 1}))
      @hotel_admin.add_reservation(Hotel::Reservation.new({checkin_date: "2015-07-20", checkout_date: "2015-07-25", room_id: 2}))
      new_hold = @hotel_admin.create_block({block_start_date: "2015-07-23", block_end_date: "2015-07-29", room_amt: 5})
      @hotel_admin.return_blocks_rooms(new_hold).count.must_equal 5
      @hotel_admin.return_blocks_rooms(new_hold).must_equal [3, 4, 5, 6, 7]
    end
  end

end
