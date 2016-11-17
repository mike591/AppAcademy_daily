# def range(start_num, end_num)
#   # return [] if end_num <= start_num + 1
#   # answer = []
#   # answer << start_num + 1
#   # answer + range(start_num + 1, end_num)
#
#   return [] if end_num < start_num
#   answer = []
#   (start_num+1...end_num).each do |el|
#     answer << el
#   end
#   answer
# end
#
# p range(1,4) # [2,3]
# p range(5,2) # []
# p range(-2,5) # [-1, 0, 1, 2, 3, 4]


# def arr_sum(arr)
#   # return arr.first if arr.length == 1
#   return nil if arr.empty?
#   # arr.first + arr_sum(arr[1..-1])
#
#   total = 0
#   arr.each { |el| total += el}
#   return total
# end
#
# p arr_sum([1,2,3]) # 6
# p arr_sum([]) # nil
# p arr_sum([1]) # 1
# p arr_sum([-5,2,3,7]) # 7

# def exp(base, power)
#   # recursion 1
#
#   # return 1 if power == 0
#   # base * exp(base, power-1)
#
#   # recursion 2
#
#     return 1 if power == 0
#     return base if power == 1
#     return exp(base, power / 2) ** 2 if power.even?
#     base * (exp(base, (power - 1) / 2) ** 2 )
#
# end
#
# p exp(2, 0) # 1
# p exp(20, 1) # 20
# p exp(2, 2) # 4
# p exp(2, 4) # 16
# p exp(3, 4) # 81
# p exp(-3, 4) # 81
# p exp(5, 3) #125
# p exp(-3, 3) # -27

# class Array
#
#   def deep_dup
#     copy = []
#
#     self.each do |el|
#       if el.is_a?(Array)
#         copy << el.deep_dup
#       else
#         copy << el
#       end
#     end
#
#     copy
#   end
#
# end
#
#
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
# # robot_parts_copy = robot_parts.dup
# # # shouldn't modify robot_parts
# # robot_parts_copy[1] << "LEDs"
# # # wtf?
# # p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
#
#
# robot_parts_copy = robot_parts.deep_dup
# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # wtf?
# p robot_parts[1] # => ["capacitors", "resistors", "inductors"]
# p robot_parts_copy[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
#
# orig = [1, [2], [3, [4]]]
# copy = orig.deep_dup
# copy[2][1] << 5
# p orig[2] # => [3, [4]]
# p copy[2] # => [3, [4,5]]
# p orig # => [1, [2], [3, [4]]]
# p copy # => [1, [2], [3, [4, 5]]]

# def fibonacci(n)
#   # return [0] if n == 1
#   # return [0, 1] if n == 2
#   # fibs_array = fibonacci(n - 1)
#   # fibs_array << (fibs_array[-1] + fibs_array[-2])
#
#   return [0] if n == 1
#   return [0, 1] if n == 2
#   fibs_array = [0, 1]
#   until fibs_array.length == n
#     fibs_array << (fibs_array[-1] + fibs_array[-2])
#   end
#
#   fibs_array
# end
#
# p fibonacci(1) # => [0]
# p fibonacci(2) # => [0 , 1]
# p fibonacci(3) # => [0, 1, 1]
# p fibonacci(10) # => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]


# def permutations(array)
#   return [array] if array.length == 1
#   first = array.shift
#   perms = permutations(array)
#   answer = []
#   perms.each do |perm|
#     (0..perm.length).each do |idx|
#       new_perm = perm[0...idx] + [first] + perm[idx..-1]
#       answer << new_perm
#     end
#   end
#
#   answer
# end
#
# # p [1,2,3].permutation.to_a.sort == [[1, 2, 3], [1, 3, 2], [2, 1, 3],
# # [2, 3, 1], [3, 2, 1], [3, 1, 2]].sort
#
# # p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
# #                         #     [2, 1, 3], [2, 3, 1],
# #                         #     [3, 2, 1], [3, 1, 2]]
#
# # p permutations([1, 2, 3, 4])
# p permutations([1, 2, 3, 4]).sort == [[1, 2, 3, 4],
#  [1, 2, 4, 3],
#  [1, 3, 2, 4],
#  [1, 3, 4, 2],
#  [1, 4, 2, 3],
#  [1, 4, 3, 2],
#  [2, 1, 3, 4],
#  [2, 1, 4, 3],
#  [2, 3, 1, 4],
#  [2, 3, 4, 1],
#  [2, 4, 1, 3],
#  [2, 4, 3, 1],
#  [3, 1, 2, 4],
#  [3, 1, 4, 2],
#  [3, 2, 1, 4],
#  [3, 2, 4, 1],
#  [3, 4, 1, 2],
#  [3, 4, 2, 1],
#  [4, 1, 2, 3],
#  [4, 1, 3, 2],
#  [4, 2, 1, 3],
#  [4, 2, 3, 1],
#  [4, 3, 1, 2],
#  [4, 3, 2, 1]].sort

require 'byebug'
#
# def bsearch(array, target)
#   return nil if array.length == 1 && array[0] != target
#   half_array_length = array.length / 2
#   mid_value = array[half_array_length]
#   if mid_value == target
#     half_array_length
#   elsif target < mid_value
#     bsearch(array[0...half_array_length], target)
#   else
#     counter = array[0...half_array_length].length
#     temp = bsearch(array[half_array_length..- 1], target)
#     counter + temp unless temp.nil?
#   end
# end
#
# puts bsearch([1, 2, 3], 1) # => 0
# puts bsearch([2, 3, 4, 5], 3) # => 1
# puts bsearch([2, 4, 6, 8, 10], 6) # => 2
# puts bsearch([1, 3, 4, 5, 9], 5) # => 3
# puts bsearch([1, 3, 4, 5, 6, 7, 8, 9, 10], 8) # => 6
# puts bsearch([1, 3, 4, 5, 6, 7, 8, 9, 10], 9) # => 7
# puts bsearch([1, 3, 4, 5, 6, 7, 8, 9, 10], 10) # => 8
# puts bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# puts bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# puts bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

class Array
  def merge_sort
    return self if self.length == 1
    half = self.length / 2
    sorted = []
    first_half = self[0...half]
    second_half = self[half..-1]

    merge(first_half, second_half)

  end

  def merge(arr1, arr2)
    merged = []
    arr1_num = []
    arr2_num = []
    all_arrays = [arr1, arr2]
    until all_arrays.all? { |arr| arr.empty? }
      arr1_num << arr2.shift if arr1.empty?
      arr2_num << arr1.shift if arr2.empty?

      arr1_num << arr1.shift if arr1_num.empty?
      arr2_num << arr2.shift if arr2_num.empty?
      # p "arr1_num: #{arr1_num}"
      # p "arr2_num: #{arr2_num}"

      if arr1_num.first < arr2_num.first
        merged << arr1_num.shift
      else
        merged << arr2_num.shift
      end
    end
    merged << arr1_num.first unless arr1_num.empty?
    merged << arr2_num.first unless arr2_num.empty?

    merged
  end
end

b = [38, 27, 43, 3, 9, 82, 10]
p b.merge_sort

# a = (1..10).to_a.shuffle
# a.merge_sort
# p a.merge_sort == (1..10).to_a

# def merge(arr1, arr2)
#   merged = []
#   arr1_num = []
#   arr2_num = []
#   all_arrays = [arr1, arr2]
#   until all_arrays.all? { |arr| arr.empty? }
#     arr1_num << arr1.shift if arr1_num.empty?
#     arr2_num << arr2.shift if arr2_num.empty?
#     # check_arr = arr1_num + arr2_num
#     # return merged + check_arr if check_arr.include?(nil)
#     if arr1_num.first < arr2_num.first
#       merged << arr1_num.shift
#     else
#       merged << arr2_num.shift
#     end
#   end
#   merged << arr1_num.first unless arr1_num.empty?
#   merged << arr2_num.first unless arr2_num.empty?
# end

# p merge([27, 38], [3, 43])
# p merge([3, 27, 38, 43], [9, 10, 82])
