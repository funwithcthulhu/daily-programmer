example = """...cite
.tilt..
...e...
.planes
...n...
.......
......."""

challenge_input = """.........
.........
.ferries.
.l.....t.
.o..an.a.
.e...e.f.
.short.f.
.......e.
..called."""

def scrabbleizer input

  #takes the input and splits it into an array by each line,
  #then splits each line into an array by character
  @matrix = input.split("\n").map {|string| string.split('')}

  @array_reg1 = []
  @array_transposed1= []
  @letter_array = []
  @word_count = []
  @answer = [] 
  @count = 0

  #Pushes each character from the matrix into a new 1 dimensional array
  #called 'array_reg1'
  @matrix.each { |row| row.each { |column| @array_reg1.push(column) } }

  #Transposes the matrix onto its side, then pushes each char into a new 
  #1 dimensional array 'array_transposed1'. This is done to collect words
  #which are spelled vertically
  @matrix.transpose.each { |row| row.each { |column| @array_transposed1.push(column) } }

  #Iterates over the input 1D array and pushes only letters which 
  #are adjacent to other letters into a new array 'letter_array'.
  #Keeps track of the length of each word and pushes
  #this value to the array 'word_count' for each word
  def letter_selector array 
    array.each_with_index do |val, index|
      next_val = array[index+1]
      last_val = array[index-1]
      case
      when val == '.'
        val.next 
        @word_count.push(@count) if @count != 0
        @count = 0
      when val != '.' && next_val == '.' && last_val == '.'
        val.next 
        @word_count.push(@count) if @count != 0
        @count = 0
      when val != '.' && next_val == nil && last_val == '.'
        @word_count.push(@count) if @count != 0
        @count = 0
        nil 
      else 
        @letter_array.push(val)
        @count+=1
      end
    end
  end

  #Selects a number of letters equal to the length of each word 
  #(word_count) and pushes the letters for each word as their 
  #own array into 'letter_array'.
  def word_selector array 
    while @word_count.size > 0
      number = @word_count.shift
      @answer.push(@letter_array[0...number])
      @letter_array.slice!(0...number)
      number = nil
    end 
  end

  #runs the eponymous methods in the correct order whenever 
  #'scrabbleizer' is called on any input
  letter_selector @array_reg1
  word_selector @letter_array
  letter_selector @array_transposed1
  word_selector @letter_array

  #joins the letters into words and puts each word
  final_answer = @answer.map { |array| array.join('') }
  final_answer.each { |word| puts word }
end 