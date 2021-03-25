require_relative 'card.rb'

class Board

  def initialize(size)
    @grid = Array.new(size) { Array.new(size, Card.new) }
    @num_pairs = size * 2
  end

  def fill_deck(num_pairs)
    deck = []
    alpha = ("A".."Z").to_a
    (0...num_pairs).each do |i|
      2.times { deck << alpha[i] }
    end
    deck
  end

  def populate
    shuffle_deck = fill_deck(@num_pairs).shuffle!
    @grid.each_with_index do |subarr, row|
      subarr.each_index do |col|
        @grid[row][col] = Card.new(shuffle_deck[4 * row + col])
      end
    end
    nil
  end

  def render
    puts "  0 1 2 3"
    @grid.each_with_index do |subarr, row|
      print "#{row}"
      subarr.each do |elem| 
        if elem.face_up
          print " #{elem.face_value}"
        else
          print "  "
        end
      end
      puts
    end
    nil
  end

  def won?
    @grid.each do |subarr|
      subarr.each { |elem| return false if elem.face_up == false }
    end
    true
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    @grid[row][col].reveal
    @grid[row][col]
  end

  def hide(pos)
    row, col = pos
    @grid[row][col].hide
    @grid[row][col]
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

end