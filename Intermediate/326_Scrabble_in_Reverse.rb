=begin
Many of us have played Scrabble, the game where you lay down tiles of letters on a board to form interlocking valid English language words. Players get points depending on the tiles they play and the bonus squares they use per word.
Now, can you reverse a Scrabble game? That is, given a board can you infer what words were played and in what order?
Given some basic rules of Scrabble:
The first word should be as centered as possible on the middle square (horizontal and vertical centering)
Each play must build off the previous word
Each play must yield valid English language words (one or more)
Words may be extended (e.g. "can" can become "cans", either by adding a single letter or by playing a new word that intersects to form a second valid word)
For your dictionary, use any standard English language dictionary (or enable1.txt).

You'll be given two integers on a line telling you how many rows and columns to read, then a board (with those dimensions) with words filled out, with blank spaces using a period .. Example:
7 8
...cite
.tilt..
...e...
.planes
...n...
.......
.......

Your program should emit one or more words, in the order in which they were played (first to last). Example:
planes
clean
cite
tilt
An alternative could be:
planes
clean
tilt
cite

Challenge input:

9 10
.........
.........
.ferries.
.l.....t.
.o..an.a.
.e...e.f.
.short.f.
.......e.
..called.

Challnege output:

an
net
short
floes
ferries
staffed
called

=end

input = """.........
.........
.ferries.
.l.....t.
.o..an.a.
.e...e.f.
.short.f.
.......e.
..called."""

#splits the input into an array of strings, each string = one line
input_array = input.split("\n")

#turns each string into its own array composed of each character 
#(letter or '.'), effectively creating a 2d array or matrix
matrix = input_array.map {|string| string.split("")}

answer_reg1 = []
answer_reg2 = []
answer_transposed1= []
answer_transposed2 = []
count = 0
word_count = []
answer = [] 

#pushes each character from the matrix into a new 1 dimensional array
# called 'answer_reg1'
matrix.each do |row|
  row.each do |column|
    answer_reg1.push(column)
  end
end

#transposes the matrix onto its side, then pushes each char into a new 
#1 dimensional array 'answer_transposed1'
matrix.transpose.each do |row|
  row.each do |column|
    answer_transposed1.push(column)
  end
end

#Iterates over the 1D array 'answer_reg1' and pushes only letters which 
#are adjacent to other letters into a new array 'answer_reg2'.
#Keeps track of the length of each word and pushes
#this value to the array 'word_count' for each word
answer_reg1.each_with_index do |val, index|
  next_val = answer_reg1[index+1]
  last_val = answer_reg1[index-1]
  case
  when val == '.'
    val.next 
    word_count.push(count) if count != 0 
    count = 0
  when val != '.' && next_val == '.' && last_val == '.'
    val.next 
    word_count.push(count) if count != 0 
    count = 0
  when val != '.' && next_val == nil && last_val == '.'
    word_count.push(count) if count != 0 
    count = 0
    nil 
  else 
    answer_reg2.push(val)
    count+=1
  end
end

#Selects a number of letters equal to the length of each word (word_count)
#and pushes the letters as their own array to a new array 'answer_reg2'
while word_count.size > 0
  number = word_count.shift
  answer.push(answer_reg2[0...number])
  answer_reg2.slice!(0...number)
  number = nil
end 

#does the same thing as the code above, but for the transposed
#array. I realized better practice would be creating a method
#for this code block so I don't have to repeat the entire block
#twice.
answer_transposed1.each_with_index do |val, index|
  next_val = answer_transposed1[index+1]
  last_val = answer_transposed1[index-1]
  case
  when val == '.'
    val.next 
    word_count.push(count) if count != 0 
    count = 0
  when val != '.' && next_val == '.' && last_val == '.'
    val.next 
    word_count.push(count) if count != 0 
    count = 0
  when val != '.' && next_val == nil && last_val == '.'
    word_count.push(count) if count != 0 
    count = 0
    nil 
  else 
    answer_transposed2.push(val)
    count+=1
  end
end

#same as above but for the transposed array
while word_count.size > 0
  number = word_count.shift
  answer.push(answer_transposed2[0...number])
  answer_transposed2.slice!(0...number)
  number = nil
end 

#joins the letters into words and puts each word
final_answer = answer.map {|array| array.join('')}
final_answer.each { |word| puts word }