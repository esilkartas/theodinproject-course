class Game
  P1 = 'X'
  P2 = 'O'

  def initialize
    @board = Board.new
  end

  def start
    p1_move = true
    winner = nil
    loop do
      if p1_move then player = 'Player1' else player = 'Player2' end
      valid_moves = 9.times.select { |i| @board.values[i].nil? }
      puts @board.draw_board
      print "#{player}, choose any number from #{valid_moves}.\n>"
      choice = gets.to_i
      until valid_moves.include? choice do
        puts 'That move is invalid!'
        print "#{player}, choose any number from #{valid_moves}.\n>"
        choice = gets.to_i
      end
      @board.values[choice] = (p1_move ? 1 : 0)
      winner = game_over?
      break if winner
      p1_move = (p1_move ? false : true)
    end

    if winner == P1
      puts 'Player1 wins!'
    elsif winner == P2
      puts 'Player2 wins!'
    else
      puts 'It\'s a draw'
    end
  end

  def game_over?
    winner = horizontal? || vertical? || diagonal?
    return winner if winner
    return no_moves?
  end

  def horizontal?
    3.times do |i|
      return P2 if 3.times.all? { |j| @board.values[3*i+j] == 0 }
      return P1 if 3.times.all? { |j| @board.values[3*i+j] == 1 }
    end
    false
  end

  def vertical?
    3.times do |i|
      return P2 if 3.times.all? { |j| @board.values[3*j+i] == 0 }
      return P1 if 3.times.all? { |j| @board.values[3*i+j] == 1 }
    end
    false
  end

  def diagonal?
    if @board.values[0] == @board.values[4] && @board.values[4] == @board.values[8]
      return P2 if @board.values[4] == 0
      return P1 if @board.values[4] == 1
    end

    if @board.values[2] == @board.values[4] && @board.values[4] == @board.values[6]
      return P2 if @board.values[0] == 0
      return P1 if @board.values[4] == 1
    end
    false
  end

  def no_moves?
    @board.values.none? { |i| i.nil? }
  end
end

class Board
  attr_accessor :values

  def initialize
    @values = Array.new(9)
  end

  # does the job, but could be better
  def draw_board
    hr1 = '     *'
    hr2 = "*****************\n"
    vals = []
    9.times do |i|
      vals << '  ' + (@values[i].nil? ? ' ' : (@values[i] == 0 ? 'O' : 'X')) + '  '
    end
    drawing = ''
    2.times do |i|
      drawing += hr1 + hr1 + "\n"
      drawing += vals[3*i+0] + '*' + vals[3*i+1] + '*' + vals[3*i+2] + "\n"
      drawing += hr1 + hr1 + "\n"
      drawing += hr2
    end
    drawing += hr1 + hr1 + "\n"
    drawing += vals[6] + '*' + vals[7] + '*' + vals[8] + "\n"
    drawing += hr1 + hr1 + "\n"
  end
end

Game.new.start