class HumanPlayer

  attr_accessor :previous_guess

  def initialize
    @previous_guess = nil
  end

  def prompt
    puts "Please enter the position of the card you'd like to flip (e.g. '2,3')"
  end

  def get_input
    pos = gets.chomp.split(",")
    pos.map {|i| i.to_i }
  end

  def receive_revealed_card(position, value)
    nil
  end

  def receive_match(pos_1, pos_2)
    nil
  end

end