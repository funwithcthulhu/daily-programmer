def next_largest(num)
  final_array = []
  num_array = num.to_s.split('').map(&:to_i)
  size = num_array.size
  multi_array = num_array.permutation(size).to_a
  multi_array = multi_array.each do |sub_array|
    final_array << sub_array.map!(&:to_s).join('').to_i
  end
  final_array.delete_if { |val| val <= num }.sort!
  return final_array[0]
end