defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "counts doubles and triples" do
    assert Day02.double_triple("abcdef") == {0, 0}
    assert Day02.double_triple("bababc") == {1, 1}
    assert Day02.double_triple("abbcde") == {1, 0}
    assert Day02.double_triple("abcccd") == {0, 1}
  end

  test "solves part one" do
    assert Day02.part_one("./lib/test_input.txt") == 12
  end

  test "solves part two" do
    input = "abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz"
    assert Day02.part_two(input) == "fgij"
  end

  test "solves part two when unique char is not in first pos" do
    input = "abcdebc\nabcdefc"
    assert Day02.part_two(input) == "abcdec"
  end
end
