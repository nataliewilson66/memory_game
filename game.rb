require_relative 'board'
require_relative 'card'
require_relative 'humanplayer'
require_relative 'computerplayer'

class Game

  attr_reader :player

  def initialize(player, size = 4)
    @board = Board.new(size)
    @board.populate
    @previous_guess = nil
    @player = player
  end

  def over?
    board.won?
  end

  def get_input
    pos = nil

    until valid_input?(pos)
      pos = player.get_input
    end

    pos
  end

  def valid_input?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, 3) }
  end

  def compare_guess(new_guess)
    if previous_guess
      if match?(previous_guess, new_guess)
        player.receive_match(previous_guess, new_guess)
      else
        board.hide(previous_guess)
        board.hide(new_guess)
      end
      self.previous_guess = nil
      player.previous_guess = nil
    else
      self.previous_guess = new_guess
      player.previous_guess = new_guess
    end
  end

  def match?(pos1, pos2)
    board[pos1] == board[pos2]
  end

  def make_guess(guessed_pos)
    revealed_value = board.reveal(guessed_pos)
    player.receive_revealed_card(guessed_pos, revealed_value)
    board.render
    
    compare_guess(guessed_pos)

    sleep(1)
    board.render
  end

  def play
    until self.over?
      system("clear")
      board.render
      player.prompt
      pos = self.get_input
      self.make_guess(pos)
    end
    puts "You won!"
  end

  private

  attr_accessor :previous_guess
  attr_reader :board

end

game1 = Game.new(ComputerPlayer.new(4))
game1.play

game2 = Game.new(HumanPlayer.new)
game2.play
