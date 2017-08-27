input = ARGV
hour = input.dup.join.split(':').first.to_i
minute = input.dup.join.split(':').last
addendum = 'am'
(hour = hour - 12) && (addendum = 'pm') if hour > 12
hour = 12 if hour == 0
time = hour.to_s + ':' + minute + addendum
puts "It's #{time}"
system("say 'its #{time}'")