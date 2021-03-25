class ComputerPlayer

  attr_accessor :previous_guess

  def initialize(size)
    @board_size = size
    @known_cards = {}
    @matched_cards = {}
    @previous_guess = nil
  end

  def prompt
    puts "Please enter the position of the card you'd like to flip (e.g. '2,3')"
  end

  def get_input
    if previous_guess
      second_guess
    else
      first_guess
    end
  end

  def unmatched_pos
    (pos, _) = @known_cards.find do |pos, val|
      @known_cards.any? do |pos2, val2|
        (pos != pos2 && val == val2) && 
          !(@matched_cards.has_key?(pos) || @matched_cards.has_key?(pos2))
      end
    end
    pos
  end

  def matched_pos
    (pos, _) = @known_cards.find do |pos, val|
      pos != previous_guess && val == @known_cards[previous_guess] && 
        !@matched_cards[pos]
    end
    pos
  end

  def random_guess
    guess = nil

    until guess && !@known_cards[guess]
      guess = [rand(4), rand(4)]
    end

    guess
  end

  def first_guess
    unmatched_pos || random_guess
  end

  def second_guess
    matched_pos || random_guess
  end

  def receive_revealed_card(position, value)
    @known_cards[position] = value
  end

  def receive_match(pos_1, pos_2)
    @matched_cards[pos_1] = true
    @matched_cards[pos_2] = true
  end


end