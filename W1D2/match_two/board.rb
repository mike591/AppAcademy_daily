class Board
  attr_reader :grid

  def initialize(size = 4)
    if size.even?
      @grid = Array.new(size) { Array.new(size)}
    else
      raise "give even # of size"
    end
  end

  def populate
    total = @grid.flatten.size
    temp_values = ((1..total/2).to_a * 2).shuffle
    @grid.map! { |arr|
      arr.map! { |spot|
        card = Card.new(temp_values.pop)
        spot = card
      }
    }

  end


  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def render
    answer = Array.new(4) {Array.new(4)}

    @grid.each_with_index do |arr, idx|
      arr.each_with_index do |obj, idx2|
        answer[idx][idx2] = obj.to_s
      end
    end

    answer.each { |line| p line}
  end



  def won?
    @grid.flatten.all? { |card| card.face_up }
  end


  def reveal(guessed_pos)
    @grid[guessed_pos[0]][guessed_pos[1]].value
  end



end
#
# def populate
#   array = Array.new(3) { Array.new(4) }
#   temp_values= ((1..6).to_a * 2).shuffle
#   array.map! { |arr|
#     arr.map! { |spot|
#       spot = temp_values.pop
#     }
#   }
#   p array
# end
