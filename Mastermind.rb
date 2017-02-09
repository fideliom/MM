module StartTheGame

	def self.display_intro
		puts "**********************************************************"
		puts "* Welcome to the Mastermind Game!                        *"
		puts "* When gueesing the colors, please enter the following:  *"
		puts "* b for blue, r for red, g for green, y for yellow       *"
		puts "* rs for rose, and sb for skyblue.                       *"
		puts "* Let's play!                                            *"
		puts "**********************************************************"
	end

	def self.get_name_of(player)
		print " =>Please enter your name: "
		player.name = gets.chomp.capitalize
	end

end

module GameRules

	def check 
		c = gets.chomp.downcase
		case c
		when 'r'
			:red
		when 'g'
			:green
		when 'b'
			:blue
		when 'o'
			:orange
		when 'y'
			:yellow
		when 'p'
			:purple
		when 'rs'
			:rose
		when 'sb'
			:skyblue
		else
			print "Please enter one of the specified color symbols: "
			check 
		end
	end

	def get str
		print " =>Please enter the #{str}: "
	end

	def guess_code 
		arr = []
		get 'first color'
		color = check
		arr << color
		get 'second color'
		color = check
		arr << color
		get 'third color'
		color = check
		arr << color
		get 'fourth color'
		color = check
		arr << color
		arr
	end
	
	def feedback(arr1, arr2)
	i = 0
	black = 0
	white = 0
	arr = []
	while (i < arr2.size)
		if (arr1[i] == arr2[i])
			white += 1
			arr << i
		end	
		arr.each do |b|
			if (arr2.include?(arr[b]))
				black += 1
			end
		end
		i += 1
	end
	[white, black]
	end

	def display arr
		arr.each do |a|
			print "|#{a.to_s}"
		end
		puts "|"
	end

end

class MastermindGame

	attr_reader :player
	def initialize player_name
		@player = Player.new(player_name)
		@secret_code = [:red, :blue, :green, :yellow, :orange, :purple, :rose, :skyblue].sample 4
		@feedback = []
	end

	class Player
		attr_accessor :name
		attr_accessor :code
		def initialize name
			@name = name
			@code = []
		end
	end

	def secret_code
		@secret_code
	end

	include GameRules

end

mastermind = MastermindGame.new('')
StartTheGame.display_intro
StartTheGame.get_name_of(mastermind.player)
lost = true
12.times do |t|
	mastermind.player.code = mastermind.guess_code
	if(mastermind.player.code == mastermind.secret_code)
		puts " =>You win!"
		puts "it took you #{t} guesses to break the code."
		lost = false
		break
	else
		fb = mastermind.feedback(mastermind.player.code, mastermind.secret_code)
		fb[0].times do
			print '|white'
		end
		fb[1].times do
			print '|black'
		end
		puts "|"
	end
end
if (lost)
	puts " =>You couldn't guess the secret code."
	puts " =>You lose!"
end