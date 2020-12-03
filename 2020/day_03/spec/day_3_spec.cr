require "spec"
require "../day_03"

describe Toboggan do
  describe "#initialize" do
    it "initializes the map" do
      map = <<-STRING
      ..##
      #..#
      STRING

      t = Toboggan.new(map)
      t.height.should eq 2
      t.width.should eq 4
    end
  end

  describe "#move" do
    it "moves the cursor and returns the contents of the new location" do
      map = <<-STRING
      ..##
      #..#
      STRING

      t = Toboggan.new(map)
      t.move(3,1).should eq "#"
    end
  end

  describe "#loop_and_count" do
    it "counts trees" do
      map = File.read("test_input.txt")
      t = Toboggan.new(map)
      t.loop_and_count(3,1).should eq 7
    end
  end

  describe "#multiply_counts" do
    it "multiplies all of the counts" do
      map = File.read("test_input.txt")
      t = Toboggan.new(map)
      slopes = [
        [1, 1],
        [3, 1],
        [5, 1],
        [7, 1],
        [1, 2]
      ]
      t.multiply_counts(slopes).should eq 336
    end 
  end
end