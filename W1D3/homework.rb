def sum_to(n)
  return 1 if n == 1
  return nil if n < 1
  n + sum_to(n-1)
end

p sum_to(5)  # => returns 15
p sum_to(1)  # => returns 1
p sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil

def add_numbers(arr = nil)
  return nil if arr.nil?
  return arr[0] if arr.size == 1
  arr.shift + add_numbers(arr)
end

p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers() # => returns nil

def gamma_fnc(n)
  return gamma_fnc_helper(n-1)
end

def gamma_fnc_helper(n)
    return nil if n < 0
    return 1 if n == 0
    return n * gamma_fnc_helper(n-1)
end


p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040
