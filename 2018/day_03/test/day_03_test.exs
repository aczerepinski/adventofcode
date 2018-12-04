defmodule Day03Test do
  use ExUnit.Case
  doctest Day03


  test "counts contested squares" do
    input = """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """

    assert Day03.contested_squares(input) == 4
  end

  test "finds uncontested claim" do
    input = """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """

    assert Day03.uncontested_claim(input) == 3
  end

end
