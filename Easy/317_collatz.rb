def collatz(input)
  dict = { 'a' => 'bc', 'b' => 'a', 'c' => 'aaa' }
  input.slice!(1)
  puts input << dict[input.slice!(0)]
  collatz(input) if input != 'a'
end
