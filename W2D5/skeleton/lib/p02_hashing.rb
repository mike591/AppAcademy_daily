class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  #[1,2, "hello", { hello: world}]
  #self.map { |el| el.hash }

  #
  def hash
    self.map { :hash }
    self.join.hash
  end
end

class String
  def hash
    str = self.split('')
    str.map{|char| char.ord }.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = self.to_a.sort!
    arr.hash
    # 0
  end
end
