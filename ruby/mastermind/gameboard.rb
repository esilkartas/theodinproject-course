module Mastermind
  # class for command line drawing of game board
  class GameBoard
    # board has 3 columns, therefore 3 arrays are needed for game info storage
    def initialize(colors = 4, turn_count = 12)
      @turns = (0...turn_count).to_a
      @codes = Array.new(turn_count, Array.new(colors, '-'))
      @feedbacks = Array.new(turn_count, Array.new(colors, '-'))
    end

    # computes a string of board representation
    def make_drawing
      drawing = "Turn\tCode\t\t\tFeedback\n" + ''.rjust(4) + "\t? ? ? ?\n"
      drawing = (0...@turns.size).reverse_each.inject(drawing) do |mem, var|
        mem += drawing_component(var) + "\n"
      end
      drawing
    end

    # computes a string for each line in game board
    # each line represents a single turn in the game
    def drawing_component(current_turn)
      component = (@turns[current_turn]+1).to_s.rjust(4)
      component += "\t" + @codes[current_turn].inject('') do 
        |mem, var| mem += mem.empty? ? var : ' ' + var
      end
      component += "\t\t" + @feedbacks[current_turn].inject('') do
        |mem, var| mem += mem.empty? ? var : ' ' + var
      end
      component
    end

    def update_codes(turn, code)
      @codes[turn - 1] = code
    end

    def update_feedbacks(turn, feedback)
      @feedbacks[turn - 1] = feedback.map { |i| i.to_s }
    end
  end
end