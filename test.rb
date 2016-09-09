require_relative "board.rb"
require_relative "card.rb"

c1 = Card.new
c2 = Card.new
c3 = Card.new
c4 = Card.new

cards = []

cards << c1
cards << c2
cards << c3
cards << c4

board = Board.new(cards)
board.populate
board[1,1]
