# Daily Programmer - Easy - 346
# Cryptarithms are a kind of mathematical puzzle. Each puzzle
# consists of a basic equation of arithmetic (involving addition,
# subtraction, division, etc.) with words, where each letter
# represents a different digit. The goal of the puzzle is to
# find the correct number substitution for each letter in order
# to make a valid equation.

# This classic example (taken from the wikipedia page) was first published in 1924:

#     S E N D
# +   M O R E
#_______________
#   M O N E Y

# The solution to this puzzle is:

# O = 0,
# M = 1,
# Y = 2,
# E = 5,
# N = 6,
# D = 7,
# R = 8,
# and S = 9.

# (i.e. 9567 + 1085 = 10652)

# Note: Leading zeroes are not allowed in a valid solution.

# Task
# You will be given a cryptarithm in string form. Your task
# is to output the letters and corresponding numbers which
# make up a valid solution to the puzzle.

# For the purposes of this challenge, all equations will consist only of addition.

# Leading zeroes (in a multi-digit number) are not allowed in a valid solution.

# The input is guaranteed to be a valid cryptarithm.

# Example
# Input:
# "THIS + IS + HIS == CLAIM"

# Output:
# {"A"=>7, "C"=>1, "H"=>8, "I"=>5, "L"=>0, "M"=>6, "S"=>2, "T"=>9}

require 'benchmark'

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

module CryptSolver
  def self.solve(input_string)
    @key = {}
    @equation = input_string
    self.find_uniq_letters
    self.find_possible_keys
    @key
  end

  def self.find_uniq_letters
    @letters = @equation.gsub(/[^A-Z]/, '').chars.uniq.sort.join
  end

  def self.find_possible_keys
    size = @letters.size
    (0..9).to_a.permutation(size) do |ar| 
      @eq = @equation.tr(@letters, ar.join(''))
      next if self.detect_leading_zero(@eq)
      self.assemble_key(@letters, ar.join('')) if eval(@eq)
      break if eval(@eq)
    end
  end

  def self.detect_leading_zero(a)
    a.split(/\s+/).select { |a| a.numeric? }.each do |i|
      return true if i.size > 1 && i.chars.first == '0'
    end
    false
  end

  def self.assemble_key(letters, poss)
    letters.size.times do |i|
      @key[letters[i]] = poss[i].to_i
    end
  end
end

Benchmark.bm do |x|
  x.report('cryptsolver: ') { CryptSolver.solve("WHAT + WAS + THY == CAUSE") }
  x.report('cryptsolver: ') { CryptSolver.solve("HIS + HORSE + IS == SLAIN") }
  x.report('cryptsolver: ') { CryptSolver.solve("HERE + SHE == COMES") }
  x.report('cryptsolver: ') { CryptSolver.solve("FOR + LACK + OF == TREAD") }
  x.report('cryptsolver: ') { CryptSolver.solve("I + WILL + PAY + THE == THEFT") }
  x.report('cryptsolver: ') { CryptSolver.solve("TEN + HERONS + REST + NEAR + NORTH + SEA + SHORE + AS + TAN + TERNS + SOAR + TO + ENTER + THERE + AS + HERONS + NEST + ON + STONES + AT + SHORE + THREE + STARS + ARE + SEEN + TERN + SNORES + ARE + NEAR == SEVVOTH") }
  x.report('cryptsolver: ') { CryptSolver.solve("SO + MANY + MORE + MEN + SEEM + TO + SAY + THAT + THEY + MAY + SOON + TRY + TO + STAY + AT + HOME +  SO + AS + TO + SEE + OR + HEAR + THE + SAME + ONE + MAN + TRY + TO + MEET + THE + TEAM + ON + THE + MOON + AS + HE + HAS + AT + THE + OTHER + TEN == TESTS") }
  x.report('cryptsolver: ') { CryptSolver.solve("THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES") }
end
