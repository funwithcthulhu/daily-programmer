# Daily Programmer - #347 Intermediate - Line Feedback Shift Register

# Description

# In computing, a linear-feedback shift register (LFSR) is a shift
# register whose input bit is a linear function of its previous state.
# The most commonly used linear function of single bits is exclusive-or (XOR).
# Thus, an LFSR is most often a shift register whose input bit is driven by
# the XOR of some bits of the overall shift register value.

# The initial value of the LFSR is called the seed, and because the
# operation of the register is deterministic, the stream of values produced
# by the register is completely determined by its current (or previous)
# state. Likewise, because the register has a finite number of possible states,
# it must eventually enter a repeating cycle.

# Your challenge today is to implement an LFSR in software.

# Example Input
# You'll be given a LFSR input on one line specifying the tap positions
# (0-indexed), the feedback function (XOR or XNOR), the initial value with
# leading 0s as needed to show you the bit width, and the number of clock steps
# to output. Example:

# [0,2] XOR 001 7
# Example Output
# Your program should emit the clock step and the registers (with leading 0s)
# for the input LFSR. From our above example:

# 0 001
# 1 100
# 2 110 
# 3 111
# 4 011
# 5 101
# 6 010
# 7 001

# Challenge Input

# [1,2] XOR 001 7
# [0,2] XNOR 001 7
# [1,2,3,7] XOR 00000001 16
# [1,5,6,31] XOR 00000000000000000000000000000001 16

# Challenge Outut
# (Only showing the first two for brevity's sake.)

# 0 001
# 1 100 
# 2 010
# 3 101
# 4 110
# 5 111
# 6 011
# 7 001

# 0 001
# 1 000
# 2 100
# 3 010
# 4 101
# 5 110
# 6 011
# 7 001

# Further Reading
# Tutorial: Linear Feedback Shift Registers (LFSRs) - Part 1 from the IEEE
# https://www.eetimes.com/document.asp?doc_id=1274550

# Linear Feedback Shift Registers Theory and Applications - some lecture notes from Kwal Saluja
# http://homepages.cae.wisc.edu/~ece553/handouts/LFSR-notes.PDF

# Bonus
# Write a function that detects the periodicity of the LFSR configuration.


def lfsr(taps, fb, value, steps, t = 0)
  return if t > steps
  val = value.chars.map(&:to_i)
  puts "#{t} #{val.join}"
  val.unshift(feedback(val, taps, fb)).pop
  lfsr(taps, fb, val.join, steps, t + 1)
end

def feedback(val, taps, fb)
  sel = ->(val, taps) { val.select.with_index { |v, idx| taps.include?(idx) } }
  return sel[val, taps].reduce { |t, v| t ^ v } if fb == 'XOR'
  return sel[val, taps].reduce { |t, v| 1 - (t ^ v) } if fb == 'XNOR'
  raise ArgumentError.new('Invalid feedback')
end

lfsr([0,2], 'XOR', '001', 7)
lfsr([0,2], 'XNOR', '001', 7)
lfsr([1,2,3,7], 'XOR', '00000001', 16)
lfsr([1,5,6,31], 'XOR', '00000000000000000000000000000001', 16)


# Alternate version which accepts a single string as input

def lfsr(input, t = 0)
  input_array = input.split(/\s+/)
  steps = input_array[3].to_i
  return if t > steps
  taps, fb, val = input_array[0], input_array[1], input_array[2].chars.map(&:to_i)
  puts "#{t} #{val.join}"
  val.unshift(feedback(val, eval(taps), fb)).pop
  lfsr("#{taps} #{fb} #{val.join} #{steps}", t + 1)
end

def feedback(val, taps, fb)
  sel = ->(val, taps) { val.select.with_index { |v, idx| taps.include?(idx) } }
  return sel[val, taps].reduce { |t, v| t ^ v } if fb == 'XOR'
  return sel[val, taps].reduce { |t, v| 1 - (t ^ v) } if fb == 'XNOR'
  raise ArgumentError.new('Invalid feedback')
end
