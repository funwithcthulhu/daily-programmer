
def lucky(max)
  start = Time.now
  @array = 1.step(max, 2).to_a.unshift(0)
  ind = 2
  until @array[ind] == @array.last
    val = @array[ind]
    @array.each_index { |i| @array[i] = nil if i % val == 0 && @array[i] > val }
    ind += 1
    @array.compact!
  end
  @array.last
  puts Time.now - start
end
