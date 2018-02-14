=begin
Intermediate 351 Permutation Madness
Description
Permutation madness

A group of programs has gotten together in a line and have started dancing

They appear to have 3 dance moves.

Try Spin that's a good trick, the right end swaps up most left keeing their order

Exchange Two programs appear to swap depending on the numbers given

Partner Two programs that know eachother swaps

Input description
a list of programs in their initial order

First you will be given a string of characters, each character is an individual program

On the next line you will get a list of moves split by ,

The moves work as following:

Spin is given as SN where N is a positive integer. This moves N programs from the right up front, keeping their order

Exchange is given as xA/B where A and B are the positions of two programs that will swap positions

Partner is given as pA/B where A and B refer to the original positions of the programs and swaps them whereever they currently are

Output description
The output is the final order the list of programs stand in after they are done dancing

Input example
abcde
s1,x3/4,p4/1
Everything is 0 indexed

Output example
abcde (initial)
eabcd (s1)
eabdc (x3/4)
baedc (p4/1)
You only have to return the final state

=end

def spin(arr, n)
  n.times { |t| arr.unshift(arr.pop) }
end

def exchange(arr, a, b)
  arr[a], arr[b] = arr[b], arr[a]
end

def partner(arr, original, a, b)
  a, b = arr.index(original[a]), arr.index(original[b])
  exchange(arr, a, b)
end

def madness(string, instructions)
  original, arr = string.chars, string.chars
  instructions.split(',').each do |command|
    comm = command.chars
    command = comm.shift
    comm = comm.join('').split("/")
    case command
    when 's' then spin(arr, comm.join('').to_i)
    when 'x' then exchange(arr, comm[0].to_i, comm[1].to_i)
    when 'p' then partner(arr, original, comm[0].to_i, comm[1].to_i)
    end
  end
  arr.join
end
