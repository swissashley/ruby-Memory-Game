require_relative "card.rb"
require_relative "board.rb"
require_relative "humanplayer.rb"
require_relative "computerplayer.rb"
require "byebug"

class MemoryGame
  attr_accessor :board, :player

  def initialize(board = nil, player = nil)
    @board = board
    @player = player
  end

  def play
    @board.populate
    while true
      make_guess
      break if over?
    end
    print "Game OVER!!"
  end

  def render
    @board.render
  end

  def make_guess
    first_card = self.guess_and_show(1)
    self.render

    second_card = self.guess_and_show(2)
    self.render
    unless over? || compare(first_card.to_s, second_card.to_s)
      first_card.hide
      second_card.hide
    end

    player.remove_cards_from_known_cards(first_card, second_card)

    sleep 3
    system("clear")

  end

  def guess_and_show(round)
    @player.prompt
    pos = @player.get_input(round)
    guess_and_show(round) if @board[*pos].reveal?
    @board[*pos].reveal
    @board[*pos]
  end

  def compare (num1, num2)
    num1 == num2
  end

  def over?
    @board.won?
  end

  # def prompt
  #   puts "Please enter a (x,y) pos: "
  #   pos = gets.chomp
  #   pos.split(",").map(&:to_i)
  # end
end

if __FILE__ == $PROGRAM_NAME
  c1 = Card.new(false, 0)
  c2 = Card.new(false, 0)
  c3 = Card.new(false, 1)
  c4 = Card.new(false, 1)

  cards = []

  cards << c1
  cards << c2
  cards << c3
  cards << c4

  board = Board.new(cards)

  my_human = HumanPlayer.new("Human", board)
  my_comp = ComputerPlayer.new("Gizmo", board)

  my_game = MemoryGame.new(board, my_comp)
  my_game.play
end
