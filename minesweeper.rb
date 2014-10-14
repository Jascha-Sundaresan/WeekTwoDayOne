require './tile'
require './board'



class Game
  
  class InputError < StandardError; end
  
  attr_reader :board
  
  def initialize(num)
    @board = Board.new(num)
    @size = num
  end
  
  def play
    until @board.over?
      @board.display
      move = get_move
      p move
      make_move(move)
    end
    
    if @board.won?
      puts "you won!"
    else
      puts "you...didn't win!"
    end
  end

  def make_move(move)
    action = move.shift
    action == 'f' ? @board[move].flag : @board[move].reveal
  end
  
  def get_move
    puts "Move format: f/r row col  ex: f 1 3 to flag row 1 col 3"
    puts "Enter move:"
    begin
      move = gets.chomp.split
      raise InputError.new("Not a valid choice") unless valid?(move)
      move.map! {|i| i == move.first ? i : Integer(i)  }
      raise InputError.new("Already revealed") if revealed?(move.drop(1)) && move.first == 'r'
    rescue InputError => error
      puts error
      retry
    end
    move
  end
  
  def valid?(move)
    move.class == Array && 
    move.drop(1).all? {|i| ('0'...@size.to_s).include? i } && 
    move.length == 3 && 
    'rf'.include?(move.first)
  end
  
  def revealed?(move)
    @board.revealed?(move) || @board.flagged?(move)
  end
  
end


Game.new(3).play