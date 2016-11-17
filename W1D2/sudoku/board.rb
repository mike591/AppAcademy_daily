require './tile.rb'

class Board
  attr_reader :grid

  def initialize(file_name)
    file = Board.read_file(file_name)
    @grid = Array.new(9) {[]}
    for idx in 0..8
      for idx2 in 0..8
        if file[idx][idx2] == "0"
          @grid[idx] << Tile.new(file[idx][idx2], false)
        else
          @grid[idx] << Tile.new(file[idx][idx2], true)
        end
      end
    end

  end

  def self.read_file(file_name)
    File.readlines(file_name)
  end

  def render()
    @grid.each do |arr|
      arr.each do |tile|
        print "#{tile.to_s}  "
      end
      print "\n"
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, new_value)
    @grid[pos[0]][pos[1]] = new_value
  end

  # def solved?
  #
  # end

  def check_row?
    @grid.each do |arr|
      test_array = []
      arr.each do |tile|
        test_array << tile.value
        return false if tile.value.to_i == 0
      end
      return false if test_array != test_array.uniq
    end

    return true
  end

  def check_col?
    (0..8).each do |i|
      test_array = []
      @grid.each do |arr|
        test_array << arr[i].value
        return false if arr[i].value.to_i == 0
      end
      return false if test_array != test_array.uniq
    end

    return true
  end

  def check_box?
    seq = [[0,1,2], [3,4,5], [6,7,8]]
    for i in 0..2
      for j in 0..2

        test_array = []
        seq[i].each do |idx|
          seq[j].each do |idx2|
            test_array << @grid[[idx, idx2]]
            return false if test_[[idx, idx2]].value.to_i == 0
          end
        end
        return false if test_array != test_array.uniq

      end
    end

    true
  end


end



board = Board.new('sudoku1-solved.txt')
board.render
p board.check_row?
p board.check_col?
p board.check_box?
