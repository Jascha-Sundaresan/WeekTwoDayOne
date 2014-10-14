class Tile
  
  NEIGHBOR_COORDS = [
    [-1,-1],
    [-1,0],
    [-1,1],
    [0,1],
    [0,-1],
    [1,1],
    [1,0],
    [1,-1]
  ]
  attr_accessor :near_bombs
    
  def initialize pos, board
    @flagged = false
    @mined = false
    @revealed = false
    @pos = pos
    @board = board
  end
  
  def mined?
    @mined
  end
  
  def revealed?
    @revealed
  end
  
  def flagged?
    @flagged
  end
  
  def place_mine
    @mined = true
  end
  
  def to_s
    return "f" if flagged?
    #return 'x' if mined?
    return neighbor_mine_count if revealed?
    "_"
  end
  
  def reveal
    return if revealed?
    @revealed = true
    if neighbor_mine_count.zero?
      neighbors.each &:reveal
    end
  end
  
  def neighbors
    all_positions = []

    NEIGHBOR_COORDS.each do |coord|
      all_positions << [@pos.first + coord.first, @pos.last + coord.last]
    end
    valid_positions = all_positions.select{ |curr_pos| @board.valid?(curr_pos) }
    valid_positions.map{ |pos| @board[pos] }#returns all the actual tiles
  end
  
  def neighbor_mine_count
    neighbors.count &:mined?
  end
  
  def flag
    @flagged = !@flagged
    @revealed = false
  end
  
end