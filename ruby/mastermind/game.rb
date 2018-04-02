require './code.rb'
require './player.rb'
require './gameboard.rb'
require './rules.rb'

module Mastermind
  class Game

    def initialize(code_length = 4, turns = 12, duplicates = false)
      @code_length = code_length
      @turns = turns
      @duplicates = duplicates
      @code = Code.new(code_length, duplicates)
      @board = GameBoard.new(code_length, turns)
    end

    def start
      puts 'Let the game begin!' 
      turn = 1
      victory = false
      
      while turn <= @turns
        # print info for beginning of turn
        turn_beginning(turn)
        # breaker guesses code
        guess = []
        loop do
          guess = get_guessed_code()
          endturn = get_breaker_end_turn(guess)
          break if endturn == 'Y'
        end

        # get feedback
        feedback = @code.get_feedback(@code_length, guess)

        # show feedback
        puts "Here is feedback for your guess: #{feedback}"
        @board.update_codes(turn, guess)
        @board.update_feedbacks(turn, feedback)
        turn += 1

        # check feedback
        if feedback.all? { |i| i == 1 }
          victory = true
          break
        end
      end

      puts 'Final board:'
      puts @board.make_drawing

      if victory
        puts 'Congratulations, you cracked the code!'
      else
        puts 'You failed to crack the code...'
        puts "The code was #{@code.code}"
      end
    end

    def turn_beginning(turn)
      puts "Turn: #{turn}"
      puts @board.make_drawing
    end

    def get_guessed_code
      loop do
        puts "Codebreaker, select #{@code_length} colors."
        puts 'Example how to type in colors: R G B Y...'
        print('>')
        guess = gets.chomp.upcase.split(' ')

        if guess.length != @code_length
          puts "Invalid input, try again\n"
          redo
        elsif (@duplicates == false) && (guess.uniq.length != @code_length)
          puts "Make sure there are no duplicate colors!\n"
          redo
        elsif guess.any? { |i| !(Code::COLORS.include? i) }
          puts "Make sure you enter only valid colors!\n"
          redo
        end
        return guess
      end
    end

    def get_breaker_end_turn(guess)
      loop do
        puts "Codebreaker, your choice is: #{guess}."
        puts 'Do you want to proceed (Y) or remake your choice (N)?'
        print '>'
        input = gets.chomp.capitalize

        if input != 'Y' && input != 'N'
          puts 'I don\'t understand, please pick either "Y" or "N"'
          redo
        end
        return input
      end
    end
  end
end