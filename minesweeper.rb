class Board
  def initialize
    @current_board = build_board
  end
  
  def build_board
    new_board = Array.new(9) { Array.new(9) { Tile.new } }
    # 9.times do |row|
    #   9.times do |tile|
    #     new_board[row][tile] = Tile.new
    #   end
    # end
    dispence_mines(new_board)
  end
  
  def dispence_mines(new_board)
    new_board.flatten.sample(9).each { |tile| tile.place_mine }
    # total_mines = 0
    # until total_mines == 9
    #   x = rand(9)
    #   p x
    #   y = rand(9)
    #   p y
    #   current_tile = new_board[x][y]
    #   p current_tile
    #   unless current_tile.mined?
    #     current_tile.place_mine
    #     total_mines +=1
    #   end
    # end
    # p total_mines
    new_board
  end
  
  def display
    p @current_board
  end
  
  
end

class Tile
    
  def initialize
    @mined = false
  end
  
  def mined?
    @mined
  end
  
  def place_mine
    @mined = true
  end
  
end

class Game
  attr_reader :board
  
  def initialize
    @board = Board.new
  end
end


Game.new.board.display