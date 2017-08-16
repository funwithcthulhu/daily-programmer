def cipher(n)
  n.to_s.chars.map(&:ord).map { |s| s == 122 ? 97 : s += 1 }.map(&:chr).join('')
end

def decoder(n)
  n.to_s.chars.map(&:ord).map { |s| s == 97 ? 122 : s -= 1 }.map(&:chr).join('')
end
