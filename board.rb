require_relative 'card.rb'
require 'byebug'

class Board
  attr_accessor :cards, :grid_size, :game_board

  def initialize(cards)
    @cards = cards
    @grid_size = Math.sqrt(cards.count).to_i
    @game_board = []
  end

  def shuffle
    @cards.shuffle!
  end

  def populate
    shuffle
    cards_copy = cards.dup
    @grid_size.times do |i|
      row_arr = []
      @grid_size.times do |j|
        row_arr << cards_copy.pop
      end
      @game_board << row_arr
    end
    @game_board
  end

  def render
    @grid_size.times do |i|
      @grid_size.times do |j|
        print " #{self[i,j].to_s} "
      end
      puts "\n"
    end

  end

  def [](x, y)
    @game_board[x][y]
  end

  def won?
    @cards.all? { |card| card.reveal? }
  end

  def reveal(pos)
    @game_board[pos].face_value if @game_board[pos].reveal?
  end

end
