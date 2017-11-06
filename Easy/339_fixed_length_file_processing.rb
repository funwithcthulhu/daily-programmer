# Daily Programmer Easy 339 - Nov 6 2017

cache = {}
tname = nil
File.open(ARGV[0]).each_line do |line|
  unless line =~ /::EXT::/
    tname = line.match(/([A-Z]+[a-zA-Z]* [A-Z]+[a-zA-Z]*)/)[0]
    cache[tname] ||= []
  end
  if line.match('::EXT::') && line =~ /[1-9]/
    sal = line.scan(/[1-9]/).join.to_i
    cache[tname] << sal
  end
end

name = cache.key(cache.values.max)
salary = cache.values.max.join.reverse.gsub(/...(?=.)/, '\&,').reverse

puts name + ', $' + salary
