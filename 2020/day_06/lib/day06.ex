defmodule Day06 do
  def sum_groups(input, count_fn) do
    groups(input)
    |> Enum.map(count_fn)
    |> Enum.reduce(0, &+/2)
  end

  def groups(input) do
    String.split(input, "\n\n")
  end

  def count_unanimous(input) do
    member_count = length(String.split(input, "\n"))

    String.replace(input, "\n", "")
    |> String.to_charlist()
    |> Enum.reduce(%{}, &increment_answer/2)
    |> Map.values()
    |> Enum.filter(fn n -> n == member_count end)
    |> length
  end

  def count_group(input) do
    String.replace(input, "\n", "")
    |> String.to_charlist()
    |> Enum.reduce(%{}, &record_answer/2)
    |> Map.values()
    |> Enum.reduce(0, &+/2)
  end

  defp record_answer(char, acc) do
    Map.put(acc, char, 1)
  end

  defp increment_answer(char, acc) do
    Map.update(acc, char, 1, fn val -> val + 1 end)
  end
end

{:ok, input} = File.read("./input.txt")
IO.puts(Day06.sum_groups(input, &Day06.count_group/1))
IO.puts(Day06.sum_groups(input, &Day06.count_unanimous/1))
