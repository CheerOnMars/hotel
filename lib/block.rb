# require 'time'
# require_relative 'reservation'
# require_relative 'hotel_admin'
#
# module Hotel
#   class Block
#     attr_reader :block_start_date, :block_end_date, :room_amt
#
#     def initialize(input)
#
#       if input[:block_start_date] == nil || input[:block_end_date] == nil
#         raise ArgumentError.new("Date must be a date.")
#       end
#
#       if input[:block_start_date] >= input[:block_end_date]
#         raise ArgumentError.new("End date must be after start date.")
#       end
#
#       if input[:room_amt] > 5 || input[:room_amt] < 1
#         raise ArgumentError.new("Rooms must be between 1 and 5.")
#       end
#
#       # if input[:room_num] > Hotel::HotelAdmin.view_available_rooms(input[:block_start_date], input[:block_end_date])
#       #   raise ArgumentError.new("There are not enough rooms available during that time.")
#       # end
#
#       if input[:room_amt] > 5 || input[:room_amt] < 1
#         raise ArgumentError.new("Rooms must be between 1 and 5.")
#       end
#
#       @block_start_date = input[:block_start_date]
#       @block_end_date = input[:block_end_date]
#       @room_num = input[:room_amt]
#     end
#
#
#   end
# end
