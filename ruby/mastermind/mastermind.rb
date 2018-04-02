require './game.rb'

howto = %(
HOW TO PLAY

Computer generates a code and your job is to figure it out
The code consists of these colors:
#{Mastermind::Code::MAPPINGS}
)
print howto
# first param - code length, second - turn count, third - allow duplicate colors?
Mastermind::Game.new(4, 12, true).start