require "spec"
require "../day_3.cr"

describe "Spiral" do
  it "calculates Manhattan Distance between source and 1" do
    spiral(1).should eq 0
    spiral(12).should eq 3
    spiral(23).should eq 2
    spiral(1024).should eq 31
  end
end
  
describe "Adjacent Sums Set" do
  it "returns the first number in the set larger than input" do
    adjacent_sums_set(2).should eq 4
    adjacent_sums_set(11).should eq 23
    adjacent_sums_set(54).should eq 57
    adjacent_sums_set(362).should eq 747
  end
end