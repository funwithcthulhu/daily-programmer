class Login
  
	attr_accessor :username
	attr_accessor :password
	attr_accessor :temp
	attr_accessor :key

	def initialize(str)
		@username = str
  end

	def pw  
		puts "please choose a password (allowed characters include: a-z, 0-9, '!@#$%^&*()')"
		print "> "
		@temp = gets.chomp 
		if valid_pw? @temp
			@password = @temp
			@temp = ''
		else
			puts 'Invalid password.'
			pw 
		end 
	end

	private

	def valid_pw? str
		valid_characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['!','@','#','$','%','^','&','*','(',')']
		str.chars.all? { |c| valid_characters.include? c }
	end 

	def encode str 
		str.chars.map {|char| char.ord + @key}

	def key
		@key = rand(51..155)
	end

end


def login 
	puts "Please enter username:"
	print "> "
	str = gets.chomp
	log = Login.new.login str
end 



 