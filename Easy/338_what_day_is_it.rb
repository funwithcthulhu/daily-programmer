what_day = ->(year, month, day) { Time.new(year, month, day).strftime('%A') }

DATA.each_line do |line|
  puts what_day[line.split(/\s+/)[0], line.split(/\s+/)[1], line.split(/\s+/)[2]]
end

__END__
2017 10 30
2016 2 29
2015 2 28
29 4 12
570 11 30
1066 9 25
1776 7 4
1933 1 30
1953 3 6
2100 1 9
2202 12 15
7032 3 26