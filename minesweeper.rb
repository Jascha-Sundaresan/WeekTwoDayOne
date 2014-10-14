#!/usr/bin/env ruby

require './tile'
require './board'
require 'yaml'


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
      make_move(move)
    end
    
    if @board.won?
      puts "you won!"
    else
      puts "you...didn't win!ls"
    end
  end

  def make_move(move)
    return save if move == ["s"]
    action = move.shift
    action == 'f' ? @board[move].flag : @board[move].reveal
  end
  
  def get_move
    puts "Move format: f/r row col  ex: f 1 3 to flag row 1 col 3"
    puts "Enter move:"
    begin
      move = gets.chomp.split
      p move
      raise InputError.new("Not a valid choice") unless (valid?(move) || save?(move))
      return move if save?(move)
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
  
  def save?(move)
    move == ["s"]
  end
  
  def save
    File.open("save-game", "w") do |f|
      game = self.to_yaml
      f.puts game
    end
  end

  
end


if __FILE__ == $PROGRAM_NAME
  puts "Would you like to play a saved game? (y/N)"
  input = gets.chomp
  unless input == "y"
    puts "How large a field would you like?"
    Game.new(gets.chomp.to_i).play
  else
    puts "Please enter the name of the save file"
    input = gets.chomp
    game = YAML.load_file(input)
    game.play
  end
end
  