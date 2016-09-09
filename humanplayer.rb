require_relative 'board.rb'

class HumanPlayer
  attr_accessor :name, :board

  def initialize(name = "", board = nil)
    @name = name
    @board = board
  end

  def prompt
    puts "Please enter a (x,y) pos: "
  end

  def get_input(round)
    pos = gets.chomp
    pos.split(",").map(&:to_i)
  end

  def remove_cards_from_known_cards(*cards)

  end
end
