defmodule DayElevenTest do
  use ExUnit.Case
  doctest DayEleven

  test "counts steps from origin" do
    assert DayEleven.count_steps("ne,ne,ne") == 3
    assert DayEleven.count_steps("ne,ne,sw,sw") == 0
    assert DayEleven.count_steps("ne,ne,s,s") == 2
    assert DayEleven.count_steps("se,sw,se,sw,sw") == 3
    assert DayEleven.count_steps("se,n,se,s,sw,s,nw,n") == 1
    assert DayEleven.count_steps("sw,sw,s,se,ne,n,sw,nw,n,se,n") == 1
    assert DayEleven.count_steps("n,sw,se") == 0
  end
end
