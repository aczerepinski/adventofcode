class Toboggan
  property map : Array(Array(String))
  getter height : Int32
  getter width : Int32

  def initialize(map : String)
    @map = init_map(map)
    @x = 0
    @y = 0
    @height = @map.size
    @width = @map[0].size
  end

  def move(x : Int, y : Int)
    @x = (@x + x) % @width
    @y += y
    return "" if done?
    @map[@y][@x]
  end

  def loop_and_count(x : Int, y : Int)
    reset
    count = 0
    while !done?
      if move(x, y) == "#"
        count += 1
      end 
    end
    count
  end

  def multiply_counts(slopes : Array(Array(Int)))
    slopes.map{|slope| loop_and_count(slope[0], slope[1])}
      .reduce{|acc, n| acc == 0 ? n : acc * n}
  end

  private def done?
    @y >= @height
  end

  private def reset
    @x = 0
    @y = 0
  end

  private def init_map(map : String)
    rows = map.strip.split("\n")
    rows.map{|row| row.split("")}
  end
end

map = File.read("input.txt")
t = Toboggan.new(map)
puts "part one: #{t.loop_and_count(3,1)}"
slopes = [
  [1, 1],
  [3, 1],
  [5, 1],
  [7, 1],
  [1, 2]
]
puts "part two: #{t.multiply_counts(slopes)}"