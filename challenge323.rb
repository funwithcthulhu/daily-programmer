[4, 5, -1, -2, -7, 2, -5, -3, -7, -3, 1,
-1, -6, -3, -7, 5, -8, 2, -8, 1,
-5, -1, -4, 2, 9, -9, -6, -1, -7]

def three_sums(arr)
    return [] if arr.size < 3
    hash = {}
    threes = []
    for i in 0...arr.size
        hash.clear
        a = arr[i]
        for b in arr[(i+1)...arr.size]
            if hash.has_key?(b)
                threes << (hash[b] << b) if threes.none? { |t| t.include?(a) and t.include?(b) } # check duplicates
            else
                hash[-(a+b)] = [a,b]
            end
        end
    end
    return threes
end
