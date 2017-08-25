in1 = ARGV.first.dup
in2 = ARGV.last.dup
puts in1
0.upto(in1.length) do |i| 
  puts in2[0...i + 1] + in1[i + 1..-1] if in1[i] != in2[i]
end