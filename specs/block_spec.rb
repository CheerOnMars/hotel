# require_relative 'spec_helper'
#
#
# describe "Block class" do
#
#   describe "Initializer" do
#     before do
#       @block = Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_num: 5})
#     end
#
#     it "is an instance of Hotel::Block" do
#       @block.must_be_kind_of Hotel::Block
#     end
#
#     it "returns an error if block attempt has more than 5 rooms" do
#       proc{ Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_num: 6})}.must_raise ArgumentError
#     end
#
#     it "returns an error if block attempt has less than 1 room" do
#       proc{ Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: "2015-07-25", room_num: 0})}.must_raise ArgumentError
#     end
#
#     it "throws an argument error for a bad end date" do
#       proc{ Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: nil }) }.must_raise ArgumentError
#     end
#
#     it "throws an argument error for a bad start date" do
#       proc{ Hotel::Block.new({block_start_date: nil, block_end_date: "2015-07-20", room_num: 3 }) }.must_raise ArgumentError
#     end
#
#
#     it "throws an argument error when end date isn't after start date" do
#       proc{ Hotel::Block.new({block_start_date: "2015-07-20", block_end_date: "2015-07-20", room_num: 3 }) }.must_raise ArgumentError
#       proc{ Hotel::Block.new({block_start_date: "2015-07-21", block_end_date: "2015-07-20", room_num: 3 }) }.must_raise ArgumentError
#     end
#
#     it "can create a block of rooms" do
#
#     end
#
#     it "only includes rooms that are available for the given date range" do
#
#     end
#
#     it "excludes rooms in the block for reservations by general public" do
#     end
#
#   end
#
#   # describe "create_block method" do
#   #
#   #   it "" do
#   #   end
#   #
#   # end
#
#   describe "check_block_availability method" do
#
#     it "can check whether a given block has any rooms available" do
#     end
#
#   end
#
#   describe "reserve_room_in_block" do
#
#     it "can reserve a room from within a block of rooms" do
#     end
#
#   end
#
# end
