# r/dailyprogrammer #329 Intermediate: Solve the Water Bucket Riddle
class BucketRiddle
  attr_reader :path, :buckets

  # Create an array "@buckets" which simulates two buckets,
  # @buckets[0] is the first bucket, and @bucket[1] is
  # the second bucket.
  def initialize(m, n, l)
    @buckets = [0, 0]
    @first = m
    @second = n
    @target = l
    @path = []
    coprimes?
  end

  # Checks if m or n is larger and calls the corresponding
  # solve method "right_hand_solve" or "left_hand_solve".
  # If the final path is larger than 10 steps, returns
  # only the first and last three steps of the path.
  def solve
    @second > @first ? right_hand_solve : left_hand_solve
    if @path.length > 10
      "#{@path[0..3]}, ... #{@path[-3..-1]} steps: #{@path.length}"
    else
      @path
    end
  end

  private

  # Checks if input are coprimes using Ruby's 'gcd' method,
  # which finds the greatest common denominator. If the gcd is
  # not 1, then an error is raised.
  def coprimes?
    nse = NoSolutionError.new('Input numbers must be coprimes')
    raise nse unless @first.gcd(@second) == 1
  end

  # Finds the solution by filling the larger right bucket,
  # moving water from the right bucket to the left until the
  # left bucket is full, emptying the left bucket, then moving
  # the remaining water in the right bucket to the left bucket.
  # Then, fill the right bucket again, rinse, and repeat. The
  # method halts when the target number is found in the second
  # bucket (@buckets[1]).
  def right_hand_solve
    until @buckets[1] == @target
      fill_right
      until @buckets[1].zero?
        right_to_left
        break if @buckets.include?(@target)
        empty_left
        break if @buckets.include?(@target)
        right_to_left
        break if @buckets.include?(@target)
      end
    end
  end

  # Does the same thing as 'right_hand_solve' except in the
  # opposite direction--filling the larger left bucket and
  # transferring "water" to the right.
  def left_hand_solve
    until @buckets[0] == @target
      fill_left
      until @buckets[0].zero?
        left_to_right
        break if @buckets.include?(@target)
        empty_right
        break if @buckets.include?(@target)
        left_to_right
        break if @buckets.include?(@target)
      end
    end
  end

  # Moves the "water" from the left "bucket" (@buckets[0])
  # to the right "bucket" (@buckets[1]). If there is more
  # water in the right "bucket" than will fit, fills the
  # bucket, and keeps the remainder in the left "bucket".
  def left_to_right
    @buckets[1] = @buckets[1] + @buckets[0]
    @buckets[0] = if @buckets[1] > @second
                    @buckets[1] - @second
                  else
                    @buckets[0] = 0
                  end
    @buckets[1] = @second if @buckets[1] > @second
    @path.push([@buckets[0], @buckets[1]])
  end

  # Does the same thing as "left_to_right" but in the
  # opposite direction
  def right_to_left
    @buckets[0] = @buckets[0] + @buckets[1]
    @buckets[1] = if @buckets[0] > @first
                    @buckets[0] - @first
                  else
                    @buckets[1] = 0
                  end
    @buckets[0] = @first if @buckets[0] > @first
    @path.push([@buckets[0], @buckets[1]])
  end

  def fill_left
    @buckets[0] = @first
    @path.push([@buckets[0], @buckets[1]])
  end

  def fill_right
    @buckets[1] = @second
    @path.push([@buckets[0], @buckets[1]])
  end

  def empty_left
    @buckets[0] = 0
    @path.push([@buckets[0], @buckets[1]])
  end

  def empty_right
    @buckets[1] = 0
    @path.push([@buckets[0], @buckets[1]])
  end
end

class NoSolutionError < ArgumentError; end

BucketRiddle.new(3, 5, 4).solve
BucketRiddle.new(6, 16, 7).solve
BucketRiddle.new(101, 317, 64).solve
BucketRiddle.new(571, 317, 420).solve
BucketRiddle.new(1699, 1409, 1334).solve
