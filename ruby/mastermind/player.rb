module Mastermind
  class Player
    attr_reader :choices

    def guess_code(count)
      @choices = []
      puts "Codebreaker, select #{count} colors."
      puts 'Example how to type in colors: RGBY'
      count.times do |i|
        puts "Your picks: #{@choices}" unless @choices.empty?
        choice = select_color(i+1)
        if valid_choice?(@choices, choice.upcase)
          @choices << choice.upcase
        else
          puts "#{choice} is not a valid color. Pick again!"
          redo
        end
      end
    end

    def select_color(count)
      print "#{count}>"
      gets.chomp
    end

    def valid_choice?(choices, choice)
      (Code::COLORS.include? choice) && !(choices.include? choice)
    end
  end
end