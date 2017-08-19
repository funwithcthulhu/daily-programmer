# G37 1337
class String
  def leeterize
    self.upcase.gsub(/[ABEILMNOSTVW]/, DICT)
  end

  def englishize
    self.gsub!('(\\)', 'N')
    array = self.upcase.chars.map do |val|
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

'I am elite.'.leeterize
'Da pain!'.leeterize
'Eye need help!'.leeterize
'3Y3 (\)33d j00 t0 g37 d4 d0c70r.'.englishize
'| n33d m4 p1llz!'.englishize
