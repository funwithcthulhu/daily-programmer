# Daily Programmer Easy 339 - Nov 6 2017

cache = {}
tname = nil
File.open(ARGV[0]).each_line do |line|
  ext = ->(line) { line.split(//).first == ':' }
  name = ->(line) { line.split(//).first =~ /[A-Z]/ }
  sal = nil
  if name[line]
    tname = line.match(/([A-Z]+[a-zA-Z]* [A-Z]+[a-zA-Z]*)/)[0]
    cache[tname] ||= []
  end
  if ext[line] && line =~ /[1-9]/
    sal = line.scan(/[1-9]/).join.to_i
    cache[tname] << sal
  end
end

salary = cache.values.max
name = cache.key(salary)
salary = sprintf('%.2f', salary.join).gsub('.00','').reverse.scan(/(\d*\.\d{1,3}|\d{1,3})/).join(',').reverse

puts name + ', $' + salary
    