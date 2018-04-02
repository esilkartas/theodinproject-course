module Mastermind
  class Rules
    def self.how_to_pick
      puts 'Codebreaker must choose 4 colors that represent Codemaster\'s code.'
    end

    def self.color_listing
      puts 'Available colors:'
      Code::MAPPINGS.each_pair { |key, value| puts "#{key} => #{value}"}
    end
  end
end