class Login
  attr_accessor :username
  attr_accessor :password
  attr_accessor :temp
  attr_accessor :key
  attr_accessor :profile
  attr_accessor :event
  def initialize
    usr 
  end

  def usr
    puts "Please enter username (allowed characters include: a-z, 0-9, '!@#$%^&*()')"
    print "> "
    @temp = gets.chomp
    if valid? @temp
      @username = encode @temp
      @temp = ''
      pw
    else
      puts 'Invalid login'
      usr
    end
    @temp = ''
  end

  def pw
    puts "please choose a password (allowed characters include: a-z, 0-9, '!@#$%^&*()')"
    print "> "
    @temp = gets.chomp
    if valid? @temp
      @password = encode @temp
      @temp = ''
    else
      puts 'Invalid password'
      pw
    end
    @temp = ''
    if @username != nil && @password != nil
      password_file = File.open('psswd.txt', 'w+')
      @profile = {@username => @password}
      password_file.puts("#{@profile.key(@password)}\n#{@profile[@username]}")
    end
  end

  def login
    puts "Please enter your username"
    print "> "
    @event = gets.chomp
    exit if @event == ''
    if @event == decode(@username)
      puts "please enter your password"
      print "> "
      @event = gets.chomp
      if @event == decode(@password)
        puts '######################'
        puts ""
        puts "Validated"
        puts ""
        puts ""
        my_file = File.open("secret-file.txt", "a+")
        loop do
          puts "Please enter command"
          puts "Type help for options"
          print "> "
          temp = gets.chomp 
          if temp.downcase.include? 'help'
            puts '######################'
            puts ""
            puts "read (read secret file)"
            puts "write (write secret file)"
            puts "esc to terminate"
            puts ""
          end
          if temp.downcase.include? 'read'
            my_file = File.open("secret-file.txt", "a+")
            puts '######################'
            puts ""
            puts my_file.read
            puts ""
            puts '######################'
          elsif temp.downcase.include? 'write'
            puts '######################'
            puts ""
            puts "Press enter to submit\n"
            print "> "
            input = gets.chomp.to_s
            File.open("secret-file.txt", "a+") do |file|
              file<< ("\n" + input)
            end
          end
          break if temp.downcase.include? 'esc'
        end
        my_file.close
      else
        puts "Invalid password"
        puts "Session Terminated"
        exit
      end
    else
      puts "Invalid username"
      login
    end
  end

  private

  def valid? str
    valid_characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ['!','@','#','$','%','^','&','*','(',')']
    str.chars.all? { |c| valid_characters.include? c }
  end

  def encode str
    keys
    str = str.to_s.split('').map(&:ord).map{|s| s += @key }.map(&:chr).join('')
  end

  def decode str
    str = str.to_s.split('').map(&:ord).map{|s| s -= @key}.map(&:chr).join('')
  end

  def keys
    @key = 50
  end
end

event = Login.new
event.login
