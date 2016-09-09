require_relative "board.rb"
require 'byebug'
class ComputerPlayer
  attr_accessor :name, :known_cards, :guesses, :board, :possible_pos

  def initialize(name ="AI", board = nil)
    @name = name
    @board = board
    @known_cards = {}
    @guesses = []
    @possible_pos = possible_pos_generate
  end

  def prompt

  end

  def get_input(round)
    if round == 1
      first_guess
    else
      second_guess
    end
  end

  # def first_guess
  #   # @known_cards = {[0,0] => "1", [0,1] =>"1"}
  #   @guesses << self.get_pair
  #   @known_cards[@guesses.first] =
  #   @guesses.first
  # end
  #
  # def second_guess
  #   @known_cards.select { |coor, value| value == cards[*@guesses.first] && coor != @guesses.first }
  # end
  #
  def first_guess # Formerly get_pair
    known_value = find_matching_card_val
    pos = find_pos(known_value)
    @guesses << pos
    @known_cards[pos] = @board[*pos].face_value.to_s
    pos
  end

  def find_matching_card_val
    temp_hash = Hash.new(0)
    @known_cards.values { |val| temp_hash[val] += 1 }
    temp_hash.select { |_, freq| freq == 2 }.keys.first
  end

  def find_pos(known_value)
    if known_value != nil
      pos = @known_cards.select do |coor, value|
        value == known_value.to_s && !guesses.include?(coor)
      end.keys.first
    else
      pos = @possible_pos.shuffle.select { |coor| !@known_cards.keys.include?(coor)}.first
    end
    pos
  end

  def second_guess

    first_pos = @guesses.first
    first_val = @board[*first_pos].face_value.to_s
    dup_known_cards = @known_cards.dup
    dup_known_cards.delete(first_pos)
    guess_found = dup_known_cards.select { |_, v| v.to_s == first_val}
    pos = find_pos(guess_found.values.first)
    @guesses = []
    @known_cards[pos] = @board[*pos].to_s
    pos

  end

  def remove_cards_from_known_cards(*selected_cards)
    @known_cards.select! { |_, val| val.to_s != selected_cards.first.to_s}
    @possible_pos.select! { |_, val| val.to_s != selected_cards.first.to_s}
  end

  def possible_pos_generate
    pos = []
    @board.grid_size.times do |i|
      @board.grid_size.times do |j|
        pos << [i,j]
      end
    end
    pos
  end

end
