class Board

  
  def initialize(num)
    @current_board = build_board(num)
    @size = num
  end
  
  def over?
    won? || lost?
  end
  
  def won?
  #   @current_board.each do |rows|
  #     rows.each do |tile|
  #       unless tile.revealed? || tile.flagged?
  #         return false
  #       end
  #     end
  #   end
    @current_board.flatten.all?{ |tile| tile.revealed? || tile.flagged? }

  end
  
  def lost?
    @current_board.flatten.any?{ |tile| tile.revealed? && tile.mined? }
  end
  
  def build_board(num)
    new_board = Array.new(num) do |row_index| 
      Array.new(num) do |col_index|
        Tile.new [row_index, col_index], self 
      end
    end
    
    dispence_mines(new_board, num)
  end
  
  def dispence_mines(new_board, num)
    new_board.flatten.sample(num).each { |tile| tile.place_mine }
    new_board
  end
  
  def display
    @current_board.each do |row|
      p row
    end
  end
  
  def revealed?(pos)
   self[pos].revealed?
  end
  
  def flagged?(pos)
   self[pos].flagged?
  end
  
  def [](pos)
    x, y = pos
    @current_board[x][y]
  end
 
  def valid?(pos)
    pos.all? { |coord| (0...@size).include?(coord) }
    # (0..8).include?(pos.first) && (0..8).include?(pos.last)
  end
  
end