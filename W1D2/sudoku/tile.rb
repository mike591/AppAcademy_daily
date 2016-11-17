require 'colorize'

class Tile
  attr_reader :value, :given

  def initialize(value, given)
    @value = value
    @given = given
  end

  def to_s
    if @given
      "#{@value}".colorize(:red)
    else
      "#{@value}"
    end
  end

end
