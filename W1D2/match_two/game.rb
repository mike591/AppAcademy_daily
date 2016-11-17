require_relative "./card.rb"
require_relative "./board.rb"


class Game
  attr_reader :board, :previous_guess

  def initialize(board, previous_guess = nil)
    @board = board
    @previous_guess = previous_guess
  end


  def make_guess(pos)
    if (pos[0] > 3) || (pos[1] > 3)
      puts "position out of bound!"
      return false
    end
    card_one = @board[@previous_guess]
    card_two = @board[pos]
    if card_one.face_up || card_two.face_up
      puts 'card already facing up'
      return false
    end
    # puts "Card one is #{card_one.value}"
    puts "Card two is #{card_two.value}"

    card_one == card_two
  end

  def play
    while !@board.won?
      @board.render


      puts "Guess first position"
      @previous_guess = gets.chomp.split(",").map { |el| el.to_i }
      puts "#{@board[@previous_guess].value} is revealed"

      puts "Guess second position"
      pos = gets.chomp.split(",").map { |el| el.to_i }


      if make_guess(pos)
        @board[@previous_guess].reveal
        @board[pos].reveal
      end

    end

    puts "Congrats!!!"
  end

end
board = Board.new
board.populate
game = Game.new(board)
game.play
