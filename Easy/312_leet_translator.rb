# G37 1337
class Translator
  def self.leeterize(string)
    string.upcase.gsub(/[ABEILMNOSTVW]/, DICT)
  end

  def self.englishize(string)
    string.gsub!('(\\)', 'N')
    array = string.upcase.chars.map do |val|
      DICT.value?(val) ? DICT.key(val) : val
    end
    array.join('').downcase.capitalize
  end

  DICT =
    {
      'A' => '4',
      'B' => '6',
      'E' => '3',
      'I' => '|',
      'L' => '1',
      'M' => '(V)',
      'N' => '(\)',
      'O' => '0',
      'S' => '5',
      'T' => '7',
      'V' => '\/',
      'W' => '`//'
    }.freeze
end

puts Translator.leeterize('I am elite.')
puts Translator.leeterize('Da pain!')
puts Translator.leeterize('Eye need help!')
puts Translator.englishize('3Y3 (\)33d j00 t0 g37 d4 d0c70r.')
puts Translator.englishize('| n33d m4 p1llz!')
