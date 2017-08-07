def cipher(n)
  n.to_s.split('').map(&:ord).map{|s| s == 122 ?
  97 : s=s+1}.map(&:chr).join('')
end

def decoder(n)
  n.to_s.split('').map {|q| q.ord}.map{|s| s == 97 ?
  122 : s=s-1}.map {|z| z.chr }.join('')
end
