include Math

class Grid
  @grid : Array(Array(Int32))
  @length : Int32
  @part_two_answer : Int32
  getter part_two_answer : Int32

  def initialize(n : Int32, record_sums = false)
    @length = axis_length(n)
    @grid = empty_grid
    @part_two_answer = fill_grid(n, record_sums)
  end

  def distance_from_center(n : Int32)
    x, y = find_number(n)
    center = axis_length(n) / 2
    (center - x).abs + (center - y).abs
  end

  private def find_number(n : Int32) : {Int32, Int32}
    @grid.each_with_index do |row, y|
      row.each_with_index do |int, x|
        if int == n
          return x, y
        end
      end
    end
    return 0, 0
  end

  private def fill_grid(n : Int32, record_sums : Bool) : Int32
    # setup
    x, y = @length / 2, @length / 2
    steps_until_rotate = 1
    steps_since_rotate = -1
    directions = [:right, :up, :left, :down]
    direction_index = 0
    current_direction = directions[direction_index]

    # populate grid
    i = 0
    loop do
      i += 1
      current_val = i > 1 && record_sums ? compute_sum(x, y) : i
      if current_val > n
        return current_val
      end

      @grid[y][x] = current_val
      steps_since_rotate += 1
      
      # rotate
      if steps_since_rotate == steps_until_rotate
        direction_index += 1
        current_direction = directions[direction_index % directions.size]
        steps_since_rotate = 0
        if [:right, :left].includes? current_direction
          steps_until_rotate += 1
        end
      end

      # move coordinates
      x, y = move(x, y, current_direction)
      if x > (@length - 1) || y > (@length - 1)
        raise "invalid coordinates: #{x}, #{y}"
      end
    end
    return n
  end

  private def axis_length(n : Int32)
    len = Math.sqrt(n).round(0).to_i
    while len % 2 == 0 || (len * len) < n || len < 3
      len += 1
    end
    return len
  end

  private def empty_grid() : Array(Array(Int32))
    grid = Array.new(@length, [] of Int32)
    (0...@length).each do |i|
      grid[i] = Array.new(@length, 0)
    end
    grid
  end

  private def move(x : Int32, y : Int32, direction : Symbol) : {Int32, Int32}
    case direction
    when :right
      return x + 1, y
    when :up
      return x, y - 1
    when :left
      return x - 1, y
    else
      return x, y + 1
    end
  end

  private def compute_sum(x : Int32, y : Int32) : Int32
    sum = 0
    [-1, 0, 1].each do |x_offset|
      [-1, 0, 1].each do |y_offset|
        if should_include_in_sum?(x, y, x_offset, y_offset)
          sum += @grid[y + y_offset][x + x_offset]
        end
      end
    end
    sum
  end

  private def should_include_in_sum?(x, y, x_offset, y_offset) : Bool
    !(x_offset == 0 && y_offset == 0) && !(x + x_offset >= @length) && !(y + y_offset >= @length)
  end
end

def spiral(n : Int32)
  grid = Grid.new(n)
  grid.distance_from_center(n)
end

def adjacent_sums_set(n : Int32)
  grid = Grid.new(n, true)
  grid.part_two_answer
end

input = 368078

puts "manhattan distance from #{input} is #{spiral(input)}"
puts "next num greater than #{input} is #{adjacent_sums_set(input)}"
