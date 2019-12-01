defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "required_fuel/1 computes required fuel for a given mass" do
    assert Day01.required_fuel(1969) == 654
    assert Day01.required_fuel(100_756) == 33583
  end

  test "recursive_fuel/1 computes the required fuel for a given mass plus fuel for the fuel" do
    assert Day01.recursive_fuel(1969) == 966
    assert Day01.recursive_fuel(100_756) == 50346
  end
end
