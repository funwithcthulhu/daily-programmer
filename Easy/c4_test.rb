puts "how many pw?"
amount_to_gen = gets.chomp
puts "how long?"
pass_length = gets.chomp

txt = File.open('passwords.txt', 'a')

j = 0
while j.to_i < amount_to_gen.to_i
    i = 0
    temp_pass = ''
    while i.to_i < pass_length.to_i
        temp_pass<<(rand 33).chr
        i += 1
        txt.write(temp_pass + '\n')
        j += 1
      end
end
txt.close
