# G37 1337
class Translator
  attr_reader :array
  def initialize(string)
    @string = string
  end

  def leeterize
    @string.upcase.gsub(/[ABEILMNOSTVW]/, DICT)
  end

  def englishize
    @string = @string.sub(/[(\\)]/, 'N')
    @array = @string.chars.map do |val|
      if DICT.values.include?(val.upcase) 
        DICT.key(val)
      else 
        val 
      end
    end
    puts @array.join('').capitalize
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

puts Translator.new('3Y3 (\)33d j00 t0 g37 d4 d0c70r.').englishize