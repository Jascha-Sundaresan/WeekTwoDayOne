class Board
  def initialize
    @current_board = build_board
  end
  
  def build_board
    new_board = Array.new(9, Array.new(9,nil))
    9.times do |row|
      9.times do |tile|
        new_board[row][tile] = Tile.new
      end
    end
    dispence_mines(new_board)
  end
  
  def dispence_mines(new_board)
    total_mines = 0
    until total_mines == 9
      x = rand(9)
      y = rand(9)
      current_tile = new_board[x][y]
      unless current_tile.mined?
        # current_tile.mined = true
        current_tile.place_mine
        total_mines +=1
      end
    end
    new_board
  end
  
  
end

class Tile
  # attr_accessor :mined
  
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
  def initialize
    @board = Board.new
  end
end