defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "splits input into groups" do
    {:ok, input} = File.read("./test_input.txt")
    assert length(Day06.groups(input)) == 5
  end

  test "counts answers for a group" do
    input = "ab\nac"
    assert Day06.count_group(input) == 3
  end

  test "counts unanimous answers for a group" do
    input = "ab\nac"
    assert Day06.count_unanimous(input) == 1
  end

  test "sums answers for all groups" do
    {:ok, input} = File.read("./test_input.txt")
    assert Day06.sum_groups(input, &Day06.count_group/1) == 11
  end
end
