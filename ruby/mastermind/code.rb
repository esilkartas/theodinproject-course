module Mastermind
  class Code
    attr_reader :code

    MAPPINGS = {'R' => 'red', 'G' => 'green', 'B' => 'blue', 'Y' => 'yellow',
                'BR' => 'brown', 'BL' => 'black', 'W' => 'white', 'O' => 'orange'}

    COLORS = ['R', 'G', 'B', 'Y', 'BR', 'BL', 'W', 'O']

    def initialize(count, duplicates)
      @code = []
      if duplicates
      count.times { @code << COLORS.sample } 
      else
        @code = COLORS.sample(count)
      end
    end

    def get_feedback(count, code)
      feedback = Array.new(count)
      placements = correct_placement?(code).count { |i| i }
      count.times { |i| feedback[i] = 1 if i < placements }
      colors = correct_colors?(code).count { |i| i }
      count.times { |i| feedback[i] = 0 if (i < colors && feedback[i] != 1) }
      count.times { |i| feedback[i] = -1 if feedback[i].nil? }
      feedback
    end

    def correct_placement?(code)
      code.size.times.map { |i| code[i] == @code[i] }
    end

    def correct_colors?(code)
      #code.map { |i| @code.any? { |j| j == i } }
      used_indexes = []
      correctness = []
      code.length.times do |i|
        code.length.times do |j|
          if !(used_indexes.include? j) && @code[j] == code[i]
            used_indexes << j
            correctness << true
            break
          end
        end
        correctness << false if correctness[i].nil?
      end
      correctness
    end

  end
end