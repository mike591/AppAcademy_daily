class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num >= @max || num < 0
  end

  def validate!(num)
  end

end

require 'byebug'

class IntSet
  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # byebug
    bucket = num % num_buckets
    @store[bucket] << num unless include?(num)
  end

  def remove(num)
    # if include? num
    bucket = num % num_buckets
    @store[bucket].delete(num)

  end


  def include?(num)
    bucket = num % num_buckets
    @store[bucket].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include? num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`

    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    arr = @store.flatten
    @store = Array.new(num_buckets * 2) {Array.new}
    arr.each do |el|
      insert(el)
    end

  end
end
