def next_largest(num)
  final_array = []
  num_array = num.to_s.split('').map(&:to_i)
  num_array.permutation(num_array.size).to_a.each do |sub_array|
    final_array << sub_array.map!(&:to_s).join('').to_i
  end
  final_array.delete_if { |val| val <= num }.sort!
  final_array[0]
end