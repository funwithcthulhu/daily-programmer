puts "What is your reddit username?"
print "> "
uname = gets.chomp
puts "What is your age?"
print "> "
age = gets.chomp
puts "And what is your name?"
print "> "
name = gets.chomp
puts "Name: #{name}\nUsername: #{uname}\nAge: #{age}"
newfile = File.open("nameinfo.txt", "w+") {|file| file.write ("Name: #{name}\nUsername: #{uname}\nAge: #{age}")}
